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
        <el-form-item label="商品类型" prop="businessId">
          <el-select v-model="listQuery.select" placeholder="请选择" @change="getCategoryGoods()">
            <el-option
              v-for="item in categoryList"
              :key="item.businessId"
              :label="item.businessId"
              :value="item.businessId">
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
          <el-button type="danger" icon="edit" @click="showPurchase(scope.$index)">购 买</el-button>
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
      <el-form v-if="dialogStatus=='purchase'" class="small-spacemenu" :model="tempTable" ref="tempTable" label-position="left" label-width="100px"
              style='width: 600px; margin-left:50px;'>
        <el-form-item>
          <p style="width: 250px;">商店名称&emsp;&emsp;{{tempTable.businessName}}</p>
          <p style="width: 250px;">商品名称&emsp;&emsp;{{tempTable.goodsName}}</p>
          <p style="width: 250px;">单价(元)&emsp;&emsp;&nbsp;{{tempTable.goodsPrice}}</p>
          <p style="width: 250px;">库存(个)&emsp;&emsp;&nbsp;{{tempTable.goodsNumbers}}</p>
          <p>购买数量&emsp;&emsp;<el-input-number size="mini" v-model="tempTable.numbers" :min="1" :max="tempTable.goodsNumbers"></el-input-number></p>
          <p style="width: 600px;" >收货地址&emsp;&emsp;
            <el-select v-model="tempTable.addressId" placeholder="请选择" size="medium">
              <el-option
                v-for="item in addressList"
                :key="item.id"
                :label="item.name+' '+item.address+' '+item.phone"
                :value="item.id">
              </el-option>
            </el-select>
          </p>
          <p style="width: 250px;">总价(元)&emsp;&emsp;&nbsp;{{tempTable.goodsPrice*tempTable.numbers}}</p>
          <p style="width: 250px;">备注信息&emsp;&emsp;
            <el-input type="textarea" :autosize="{ minRows: 2, maxRows: 4}" 
            placeholder="给商家留言" v-model="tempTable.customerComment" style="width: 250px;"/></p>
        </el-form-item>
      </el-form>
      <!-- <el-form v-if="dialogStatus=='create'||dialogStatus=='update'" class="small-spacemenu" :model="tempTable" ref="tempTable" label-position="left" label-width="100px"
              style='width: 600px; margin-left:50px;'>
        <el-form-item label="名称" prop="businessId">
          <el-input type="text" v-model="tempTable.businessId" style="width: 250px;">
          </el-input>
        </el-form-item>
        <el-form-item label="简介" prop="goodsId">
          <el-input type="text" v-model="tempTable.goodsId" style="width: 250px;">
          </el-input>
        </el-form-item>
        <p style="color:#848484;" v-if="dialogStatus=='create'"><font color="#ff0000">*</font>为新增类目的必填信息</p>
        <p style="color:#848484;" v-else><font color="#ff0000">*</font>为更新类目的必填信息</p>
      </el-form> -->
      <!-- <p v-if="dialogStatus=='delete'">确认删除?</p> -->
      <div slot="footer" class="dialog-footer">
        <el-button  type="success" @click="toPurchase(2)">购 买</el-button>
        <el-button  type="success" @click="toPurchase(1)" icon="el-icon-shopping-cart-1">加入购物车</el-button>
        <el-button @click="dialogFormVisible = false">取 消</el-button>
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
        addressList: [],
        listLoading: false,//数据加载等待动画
        listQuery: {
          pageNum: 1,//页码
          pageRow: 10,//每页条数
          searchText: "",
          select: "",
        },
        listAddressQuery: {
          pageNum: 1,//页码
          pageRow: 20,//每页条数
        },
        temp: {
          select: "全部",
        },
        dialogStatus: 'create',
        dialogFormVisible: false,
        textMap: {
          update: '编辑类目',
          create: '创建类目',
          delete: '删除类目',
          purchase: '购买商品'
        },
        tempTable: {
          goodsId: "",      //商品ID
          businessId: "",   //商店ID
          addressId: "",    //地址ID
          businessName: "", //商店名
          goodsName: "",    //商品名
          goodsPrice: "",   //单价
          numbers: "",      //购买数量
          goodsNumbers: "", //库存
          customerComment: "",//备注信息
          plan: "",         // 1、下单不支付  2、下单并支付
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
      getAddressList() {
        //查询列表
        if (!this.hasPerm('customerAddress:list')) {
          return
        }
        this.listLoading = true;
        this.api({
          url: "/address/listAddress",
          method: "get",
          params: this.listAddressQuery
        }).then(data => {
          this.listLoading = false;
          this.addressList = data.list;
          this.tempTable.addressId = this.addressList[0].id;
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

        this.tempTable.businessId = "";
        this.tempTable.goodsId = "";
        this.tempTable.id = "";
        this.dialogStatus = "create";
        this.dialogFormVisible = true;
      },
      showPurchase($index) {
        this.getAddressList();//里面给id赋了值
        this.tempTable.goodsId = this.list[$index].goodsId;
        this.tempTable.businessId = this.list[$index].businessId;
        this.tempTable.goodsPrice = this.list[$index].goodsPrice;
        this.tempTable.businessName = this.list[$index].businessName;
        this.tempTable.goodsName = this.list[$index].goodsName;
        this.tempTable.goodsNumbers = this.list[$index].goodsNumbers;
        this.tempTable.numbers = 1;
        this.dialogStatus = "purchase";
        this.dialogFormVisible = true
      },
      showUpdate($index) {
        //显示修改对话框
        this.tempTable.goodsId = this.list[$index].goodsId;
        this.tempTable.businessId = this.list[$index].businessId;
        this.tempTable.id = this.list[$index].id;
        this.dialogStatus = "update";
        this.dialogFormVisible = true
      },
      toPurchase(planNumber) {
        //保存新菜单
        this.tempTable.plan = planNumber;
        this.api({
          url: "/order/buyOneType",
          method: "post",
          data: this.tempTable
        }).then(() => {
          this.getList();
          this.dialogFormVisible = false;
          this.$message.success("下单成功");
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
