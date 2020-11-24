<template>
  <div class="app-container">
    <div class="filter-container">
      <el-form :model="listQuery" :inline="true">
        <el-form-item>
          <el-input type="text" v-model="listQuery.search" style="width: 250px;" placeholder="请输入查询内容">
          </el-input>
          </el-form-item>
          <el-form-item>
          <el-button type="primary" icon="plus" @click="getList" v-if="hasPerm('goodsManage:list')">查 询
          </el-button>
          </el-form-item>
          <el-form-item>
          <el-button type="primary" icon="plus" @click="showCreate" v-if="hasPerm('goodsManage:add')">新 增
          </el-button>
        </el-form-item>
      </el-form>
    </div>
    <el-table :data="list" v-loading.body="listLoading" element-loading-text="努力加载中.." border fit
              highlight-current-row>
      <el-table-column align="center" label="序号" width="80">
        <template slot-scope="scope">
          <span v-text="getIndex(scope.$index)"> </span>
        </template>
      </el-table-column>
      <el-table-column align="center" prop="name" label="名称" style="width: 30px;"></el-table-column>
      <el-table-column align="center" prop="price" label="单价(元)" style="width: 30px;"></el-table-column>
      <el-table-column align="center" prop="numbers" label="库存数量" style="width: 90px;"></el-table-column>
      <el-table-column align="center" prop="categoryName" label="商品种类" style="width: 90px;"></el-table-column>
      <el-table-column align="center" prop="saleStatus" label="商品状态" style="width: 90px;"></el-table-column>
      <el-table-column align="center" prop="brief" label="商品简介" style="width: 90px;"></el-table-column>
      <!-- <el-table-column align="center" label="创建时间" width="170">
        <template slot-scope="scope">
          <span>{{scope.row.createTime}}</span>
        </template>
      </el-table-column> -->
      <el-table-column align="center" label="管理" width="200" v-if="hasPerm('goodsManage:update')">
        <template slot-scope="scope" >
          <el-button type="primary" icon="edit" @click="showUpdate(scope.$index)">修 改</el-button>
          <el-button type="danger" icon="edit" @click="showDelete(scope.$index)">删 除</el-button>
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
    <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
      <el-form v-if="dialogStatus=='create'||dialogStatus=='update'" class="small-spacemenu" :model="tempTable" ref="tempTable" label-position="left" label-width="100px"
              style='width: 600px; margin-left:50px;'>
        <el-form-item label="名称" prop="name">
          <el-input type="text" v-model="tempTable.name" style="width: 250px;"/>
        </el-form-item>
        <el-form-item label="单价" prop="price">
          <el-input type="text" v-model="tempTable.price" style="width: 250px;"/>
        </el-form-item>
        <el-form-item label="库存数量" prop="numbers">
          <el-input type="text" v-model="tempTable.numbers" style="width: 250px;"/>
        </el-form-item>
        <el-form-item label="商品类型" prop="categoryName">
          <el-select v-model="tempTable.categoryId" placeholder="请选择">
            <el-option
              v-for="item in categoryList"
              :key="item.id"
              :label="item.categoryName"
              :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="商品状态" prop="statusCode">
          <el-select v-model="tempTable.statusCode" placeholder="请选择">
            <el-option
              v-for="item in statusList"
              :key="item.code"
              :label="item.name"
              :value="item.code">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="简介" prop="brief">
          <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 4}" placeholder="请提供一个简单的介绍" v-model="tempTable.brief" style="width: 250px;"/>
        </el-form-item>
      </el-form>
      <el v-if="dialogStatus=='delete'">确认删除?</el>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button v-if="dialogStatus=='create'" type="success" @click="createGoods">创 建</el-button>
        <el-button v-else-if="dialogStatus=='update'" type="success" @click="updateGoods">更 新</el-button>
        <el-button type="danger" v-else @click="deleteGoods">删 除</el-button>
      </div>
    </el-dialog>
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
          search:''
        },
        searchQuery: {
          pageNum: 1,//页码
          pageRow: 10,//每页条数
          search: "",
        },
        dialogStatus: 'create',
        dialogFormVisible: false,
        textMap: {
          update: '编辑类目',
          create: '创建类目',
          delete: '删除类目'
        },
        tempTable: {
          name: "",
          price: "",
          numbers: "",
          categoryId: "",
          statusCode: "",
          brief: "",
          id: "",
        },
        categoryList: [],
        statusList: [],
      }
    },
    created() {
      this.getList();
      this.getCategoryList();
    },
    methods: {
      getCategoryList() {
        //查询商品
        if (!this.hasPerm('goodsCategory:list')) {
          return
        }
        this.listLoading = true;
        this.api({
          url: "/goodsCategory/getAllCategories",
          method: "get",
          params: this.listQuery
        }).then(data => {
          this.listLoading = false;
          this.categoryList = data.list;
        })
      },
      getList() {
        //查询商品
        if (!this.hasPerm('goodsManage:list')) {
          return
        }
        this.listLoading = true;
        this.api({
          url: "/goodsManage/getGoodsList",
          method: "get",
          params: this.listQuery
        }).then(data => {
          this.listLoading = false;
          this.list = data.list;
          this.statusList = data.statusList;
          this.totalCount = data.totalCount;
        })
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
        this.tempTable.name = "";
        this.tempTable.price = "";
        this.tempTable.numbers = "";
        this.tempTable.categoryId = "";
        this.tempTable.statusCode = "";
        this.tempTable.brief = "";
        this.tempTable.id = "";
        this.dialogStatus = "create";
        this.dialogFormVisible = true;
      },
      showDelete($index) {
        //显示删除对话框
        this.tempTable.name = "";
        this.tempTable.price = "";
        this.tempTable.numbers = "";
        this.tempTable.categoryId = "";
        this.tempTable.statusCode = "";
        this.tempTable.brief = "";
        this.tempTable.id = this.list[$index].id;
        this.dialogStatus = "delete";
        this.dialogFormVisible = true
      },
      showUpdate($index) {
        //显示修改对话框
        this.tempTable.name = this.list[$index].name;
        this.tempTable.price = this.list[$index].price;
        this.tempTable.numbers = this.list[$index].numbers;
        this.tempTable.categoryId = this.list[$index].categoryId;
        this.tempTable.statusCode = this.list[$index].statusId;
        this.tempTable.brief = this.list[$index].brief;
        this.tempTable.id = this.list[$index].id;
        this.dialogStatus = "update";
        this.dialogFormVisible = true
      },
      createGoods() {
        //保存新菜单
        this.api({
          url: "/goodsManage/addGoods",
          method: "post",
          data: this.tempTable
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false;
          this.$message.success("商品添加成功");
        });
      },
      updateGoods() {
        //更新类目
        this.api({
          url: "/goodsManage/updateGoods",
          method: "post",
          data: this.tempTable
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false;
          this.$message.success("商品修改成功");
        });
      },
      deleteGoods() {
        //删除类目
        this.api({
          url: "/goodsManage/deleteGoods",
          method: "post",
          data: this.tempTable
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false;
          this.$message.success("商品删除成功");
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
      //     url: "/goodsManage/searchQuery",
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
