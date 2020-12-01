<template>
  <div class="app-container">
    <div class="filter-container">
      <!-- <p>{{tempTable.defaultAddress}}</p>
      <p>{{booleanValue}}</p> -->
      <el-form :model="listQuery" :inline="true">
        <el-form-item>
          <el-button type="primary" icon="plus" @click="showCreate()" v-if="hasPerm('customerAddress:add')">新 增
          </el-button>
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
      <el-table-column align="center" prop="name" label="昵称" style="width: 30px;"></el-table-column>
      <el-table-column align="center" prop="address" label="地址" style="width: 90px;"></el-table-column>
      <el-table-column align="center" prop="phone" label="联系方式" style="width: 90px;"></el-table-column>      
      <el-table-column align="center" prop="defaultAddress" label="默认地址" style="width: 90px;"></el-table-column>    
      <!-- <el-table-column align="center" label="创建时间" width="170">
        <template slot-scope="scope">
          <span>{{scope.row.createTime}}</span>
        </template>
      </el-table-column> -->
      <el-table-column align="center" label="操作" width="200" v-if="hasPerm('customerAddress:update')">
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
        <el-form-item label="昵称" prop="name">
          <el-input type="text" v-model="tempTable.name" style="width: 250px;">
          </el-input>
        </el-form-item>
        <el-form-item label="详细地址" prop="address">
          <el-input type="text" v-model="tempTable.address" style="width: 250px;">
          </el-input>
        </el-form-item>
        <el-form-item label="联系号码" prop="phone">
          <el-input type="text" v-model="tempTable.phone" style="width: 250px;">
          </el-input>
        </el-form-item>
        <el-form-item v-if="dialogStatus=='update'" label="设为默认地址" prop="defaultAddress">
        <el-switch v-model="booleanValue" active-color="#13ce66" inactive-color="#ff4949" :disabled="booleanValue2">
        </el-switch>
        </el-form-item>
      </el-form>
      <p v-if="dialogStatus=='delete'">确认删除?</p>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button v-if="dialogStatus=='create'" type="success" @click="createAddress">创 建</el-button>
        <el-button v-else-if="dialogStatus=='update'" type="success" @click="updateAddress">更 新</el-button>
        <el-button type="danger" v-else @click="deleteAddress">删 除</el-button>
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
        },
        dialogStatus: 'create',
        dialogFormVisible: false,
        textMap: {
          update: '编辑地址',
          create: '创建地址',
          delete: '删除地址'
        },
        tempTable: {
          name: "",
          phone: "",
          address:"",
          defaultAddress: "",
        },
        booleanValue: "",
        booleanValue2: "",
      }
    },
    created() {
      this.getList();
    },
    methods: {
      getList() {
        //查询列表
        if (!this.hasPerm('customerAddress:list')) {
          return
        }
        this.listLoading = true;
        this.api({
          url: "/address/listAddress",
          method: "get",
          params: this.listQuery
        }).then(data => {
          this.listLoading = false;
          this.list = data.list;
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
        this.tempTable.phone = "";
        this.tempTable.address = "";
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
        this.tempTable.name = this.list[$index].name;
        this.tempTable.address = this.list[$index].address;
        this.tempTable.phone = this.list[$index].phone;
        this.tempTable.id = this.list[$index].id;
        this.tempTable.defaultAddress = this.list[$index].defaultAddress;
        this.switchBoolean();
        this.dialogStatus = "update";
        this.dialogFormVisible = true
      },
      switchBoolean(){
        if(this.tempTable.defaultAddress==2){
          this.booleanValue = true;
        }else{
          this.booleanValue = false;
        }
        this.booleanValue2 = this.booleanValue;
      },
      getBoolean(){
        if(this.booleanValue){
          this.tempTable.defaultAddress=2;
        }else{
          this.tempTable.defaultAddress=1;
        }
      },
      createAddress() {
        //保存新菜单
        this.api({
          url: "/address/addAddress",
          method: "post",
          data: this.tempTable
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false;
          this.$message.success("地址添加成功");
        });
      },
      updateAddress() {
        //更新类目
        this.getBoolean();
        this.api({
          url: "/address/updateAddress",
          method: "post",
          data: this.tempTable
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false;
          this.$message.success("地址修改成功");
        });
      },
      deleteAddress() {
        //删除类目
        this.api({
          url: "/address/deleteAddress",
          method: "post",
          data: this.tempTable
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false;
          this.$message.success("地址删除成功");
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
