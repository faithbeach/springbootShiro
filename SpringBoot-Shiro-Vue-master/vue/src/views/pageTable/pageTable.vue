<template>
  <div class="app-container">
    <div class="filter-container">
      <el-form>
        <el-form-item>
          <el-input type="text" v-model="searchQuery.search" style="width: 250px;" placeholder="请输入查询内容">
          </el-input>
          <el-button type="primary" icon="plus" @click="doSearch" v-if="hasPerm('article:list')">查 询
          </el-button>
          <el-button type="primary" icon="plus" @click="showCreate('tempPageTable')" v-if="hasPerm('article:add')">新 增
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
      <el-table-column align="center" prop="menuCode" label="Code" style="width: 60px;"></el-table-column>
      <el-table-column align="center" prop="menuName" label="Name" style="width: 60px;"></el-table-column>
      <!-- <el-table-column align="center" label="创建时间" width="170">
        <template slot-scope="scope">
          <span>{{scope.row.createTime}}</span>
        </template>
      </el-table-column> -->
      <el-table-column align="center" label="管理" width="200" v-if="hasPerm('article:update')">
        <template slot-scope="scope" >
          <el-button type="primary" icon="edit" @click="showDelete(scope.$index)">删 除</el-button>
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
      <!-- <el-form class="small-space" :model="tempPageTable" label-position="left" label-width="60px"
               style='width: 300px; margin-left:50px;'>
        <el-form-item label="文章">
          <el-input type="text" v-model="tempPageTable.content">
          </el-input>
        </el-form-item>
      </el-form> -->
      <el-form v-if="dialogStatus=='create'" class="small-spacemenu" :model="tempPageTable" ref="tempPageTable" label-position="left" label-width="100px"
              style='width: 600px; margin-left:50px;' :rules="rules" >
        <el-form-item label="菜单名称" required prop="menuName">
          <el-input type="text" v-model="tempPageTable.menuName" style="width: 250px;">
          </el-input>
        </el-form-item>
        <el-form-item label="菜单代号" required prop="menuCode">
          <el-input type="text" v-model="tempPageTable.menuCode" style="width: 250px;">
          </el-input>
        </el-form-item>
        <p style="color:#848484;"><font color="#ff0000">*</font>为新增菜单权限的必填信息</p>
      </el-form>
      <el-h3 v-if="dialogStatus=='delete'">确认删除?</el-h3>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button v-if="dialogStatus=='create'" type="success" @click="createPageTable">创 建</el-button>
        <el-button type="primary" v-else @click="deletePageTable">删 除</el-button>
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
          pageRow: 50,//每页条数
        },
        rules: {
          menuName: [
            { required: true, message: '请输入菜单名称', trigger: 'change' },
          ],
          menuCode:[
            { required: true, message: '请输入代号名称', trigger: 'change' },
          ]
        },
        searchQuery: {
          pageNum: 1,//页码
          pageRow: 50,//每页条数
          search: "",
        },
        dialogStatus: 'create',
        dialogFormVisible: false,
        textMap: {
          update: '编辑',
          create: '创建文章',
          delete: '删除菜单'
        },
        tempPageTable: {
          menuName: "",
          menuCode: ""
        }
      }
    },
    created() {
      this.getList();
    },
    methods: {
      getList() {
        //查询列表
        // if (!this.hasPerm('article:list')) {
        //   return
        // }
        this.listLoading = true;
        this.api({
          url: "/pageTable/getAllPage",
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
      showCreate(formName) {
        //显示新增对话框
        this.tempPageTable.menuCode = "";
        this.tempPageTable.menuName = "";
        this.dialogStatus = "create"
        this.dialogFormVisible = true
        this.resetForm(formName);
      },
      showDelete($index) {
        //显示修改对话框
        this.tempPageTable.menuName = this.list[$index].menuName;
        this.tempPageTable.menuCode = this.list[$index].menuCode;
        this.dialogStatus = "delete";
        this.dialogFormVisible = true
      },
      createPageTable() {
        //保存新菜单
        this.api({
          url: "/pageTable/addPageTable",
          method: "post",
          data: this.tempPageTable
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false
        })
      },
      deletePageTable() {
        //删除文章
        this.api({
          url: "/pageTable/deletePageTable",
          method: "post",
          data: this.tempPageTable
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false
        })
      },
      doSearch(){
        this.listLoading = true;
        this.api({
          url: "/pageTable/doSearch",
          method: "get",
          params: this.searchQuery
        }).then(data => {
          this.listLoading = false;
          this.list = data.list;
          this.totalCount = data.totalCount;
        })
      },
    }
  }
</script>
