<template>
  <div class="app-container">
    <div class="filter-container">
      <el-form :model="listQuery" :inline="true">
        <el-form-item>
          <el-input type="text" v-model="listQuery.searchText" style="width: 250px;" placeholder="请输入查询内容">
          </el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="plus" @click="getList()" v-if="hasPerm('viewGoods:list')">查 询
          </el-button>
        </el-form-item>
        <el-form-item label="商品类型" prop="categoryName">
          <el-select v-model="listQuery.select" placeholder="请选择" @change="getCategoryGoods()">
            <el-option
              v-for="item in categoryList"
              :key="item.categoryName"
              :label="item.categoryName"
              :value="item.categoryName">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
    </div>
    <el-table :data="list" v-loading.body="listLoading" element-loading-text="努力加载中.." border fit
              highlight-current-row>
      <el-table-column align="center" label="序号" width="80">
        <template slot-scope="scope">
          <span v-text="getIndex(scope.$index)"></span>
        </template>
      </el-table-column>
      <el-table-column align="center" prop="goodsName" label="商品名" style="width: 30px;"></el-table-column>
      <el-table-column align="center" prop="goodsPrice" label="单价(元)" style="width: 90px;"></el-table-column>
      <el-table-column align="center" prop="goodsBrief" label="简介" style="width: 90px;"></el-table-column>
      <el-table-column align="center" label="商店名" style="width: 90px;">
        <template slot-scope="scope">
        <router-link :to="{ name: '浏览商家信息', params: { msgId: scope.row.businessId }}">
            {{scope.row.businessName}}
        </router-link>
        </template>
      </el-table-column>
      <el-table-column align="center" prop="openTime" label="营业状态" style="width: 90px;"></el-table-column>
      <el-table-column align="center" prop="closeTime" label="营业状态" style="width: 90px;"></el-table-column>
      <!-- <el-table-column align="center" label="创建时间" width="170">
        <template slot-scope="scope">
          <span>{{scope.row.createTime}}</span>
        </template>
      </el-table-column> -->
      <el-table-column align="center" label="操作" width="200" v-if="hasPerm('viewGoods:update')">
        <template slot-scope="scope" >
          <el-button type="primary" icon="edit" @click="showUpdate(scope.$index)">加 购</el-button>
          <el-button type="danger" icon="edit" @click="showDelete(scope.$index)">购 买</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="listQuery.pageNum"
      :page-size="listQuery.pageRow"
      :total="totalCount"
      :page-sizes="[10, 20, 50, 100]"
      layout="total, sizes, prev, pager, next, jumper">
    </el-pagination>
    <!-- <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
      <el-form v-if="dialogStatus=='create'||dialogStatus=='update'" class="small-spacemenu" :model="tempTable" ref="tempTable" label-position="left" label-width="100px"
              style='width: 600px; margin-left:50px;'>
        <el-form-item label="名称" prop="categoryName">
          <el-input type="text" v-model="tempTable.categoryName" style="width: 250px;">
          </el-input>
        </el-form-item>
        <el-form-item label="简介" prop="categoryBrief">
          <el-input type="text" v-model="tempTable.categoryBrief" style="width: 250px;">
          </el-input>
        </el-form-item>
        <p style="color:#848484;" v-if="dialogStatus=='create'"><font color="#ff0000">*</font>为新增类目的必填信息</p>
        <p style="color:#848484;" v-else><font color="#ff0000">*</font>为更新类目的必填信息</p>
      </el-form>
      <el-h3 v-if="dialogStatus=='delete'">确认删除?</el-h3>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button v-if="dialogStatus=='create'" type="success" @click="createCategory">创 建</el-button>
        <el-button v-else-if="dialogStatus=='update'" type="success" @click="updateCategory">更 新</el-button>
        <el-button type="danger" v-else @click="deleteCategory">删 除</el-button>
      </div>
    </el-dialog> -->
  </div>
</template>
<script>
  export default {
    data() {
      return {
        totalCount: 0, //分页组件--数据总条数
        list: [],//表格的数据
        listLoading: false,//数据加载等待动画
        listQuery: {
          pageNum: 1,//页码
          pageRow: 10,//每页条数
          searchText: "",
          select: "",
        },
        temp: {
          select: "全部",
        },
        dialogStatus: 'create',
        dialogFormVisible: false,
        textMap: {
          update: '编辑类目',
          create: '创建类目',
          delete: '删除类目'
        },
        tempTable: {
          categoryBrief: "",
          categoryName: "",
          id:"",
        },
        categoryList: [],
      }
    },
    created() {
      this.listQuery.select = "全部";
      this.temp.select = "全部"
      this.getList();
    },
    methods: {
      getList() {
        //查询列表
        if (!this.hasPerm('viewGoods:list')) {
          return
        }
        this.listLoading = true;
        this.api({
          url: "/goods/viewGoods",
          method: "get",
          params: this.listQuery
        }).then(data => {
          this.listLoading = false;
          this.list = data.list;
          this.categoryList = data.categoryList;
          this.listQuery.select = this.temp.select;
          this.totalCount = data.totalCount;
        })
      },
      getCategoryGoods(){
        this.temp.select = this.listQuery.select;
        this.getList();
      },
      handleSizeChange(val) {
        //改变每页数量
        this.listQuery.pageRow = val
        this.handleFilter();
      },
      handleCurrentChange(val) {
        //改变页码
        this.listQuery.pageNum = val
        this.getList();
      },
      handleFilter() {
        //改变了查询条件,从第一页开始查询
        this.listQuery.pageNum = 1
        this.getList()
      },
      getIndex($index) {
        //表格序号
        return (this.listQuery.pageNum - 1) * this.listQuery.pageRow + $index + 1
      },
      showCreate() {
        //显示新增对话框
        this.tempTable.categoryName = "";
        this.tempTable.categoryBrief = "";
        this.tempTable.id = "";
        this.dialogStatus = "create";
        this.dialogFormVisible = true;
      },
      showDelete($index) {
        //显示删除对话框
        this.tempTable.id = this.list[$index].id;
        this.dialogStatus = "delete";
        this.dialogFormVisible = true
      },
      showUpdate($index) {
        //显示修改对话框
        this.tempTable.categoryBrief = this.list[$index].categoryBrief;
        this.tempTable.categoryName = this.list[$index].categoryName;
        this.tempTable.id = this.list[$index].id;
        this.dialogStatus = "update";
        this.dialogFormVisible = true
      },
      createCategory() {
        //保存新菜单
        this.api({
          url: "/goodsCategory/addCategory",
          method: "post",
          data: this.tempTable
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false;
          this.$message.success("类目添加成功");
        });
      },
      updateCategory() {
        //更新类目
        this.api({
          url: "/goodsCategory/updateCategory",
          method: "post",
          data: this.tempTable
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false;
          this.$message.success("类目修改成功");
        });
      },
      deleteCategory() {
        //删除类目
        this.api({
          url: "/goodsCategory/deleteCategory",
          method: "post",
          data: this.tempTable
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false;
          this.$message.success("类目删除成功");
        })
      },
      // doSearch(){
      //   this.listLoading = true;
      //   this.searchQuery.pageNum=this.listQuery.pageNum;
      //   this.searchQuery.pageRow=this.listQuery.pageRow;
      //   if(this.searchQuery.search.trim==''||this.searchQuery.search.trim==null){
      //     this.$message.err("请输入搜索关键词");
      //     this.listLoading = false;
      //     this.getList()
      //     return
      //   }
      //   this.api({
      //     url: "/goodsCategory/searchQuery",
      //     method: "get",
      //     params: this.listQuery
      //   }).then(data => {
      //     this.listLoading = false;
      //     this.list = data.list;
      //     this.totalCount = data.totalCount;
      //   })
      // },
    }
  }
</script>
