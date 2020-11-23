<template>
  <div class="app-container">
    <div>
      <el-form ref="customerInfo" :model="customerInfo" label-width="80px" style='width: 300px; margin-left:50px;' :disabled="modifiable">
        <div>
        <el-form-item label="姓名">    
          <el-input v-model="customerInfo.name"></el-input>
        </el-form-item>
        <el-form-item label="常用号码">    
          <el-input v-model="customerInfo.phoneNumber"></el-input>
        </el-form-item>
        <el-form-item label="账户余额">
          <el-input :disabled="true" v-model="customerInfo.balance"></el-input>
        </el-form-item>
        </div>
        </el-form>
        <el-form ref="customerInfo" label-width="80px" style='width: 300px; margin-left:50px;'>
        <el-form-item v-if="status=='view'">
          <el-button type="primary" @click="toModifyInfo">修改</el-button>
          <el-button type="primary" @click="showModifyAccount">更改账号密码</el-button>
        </el-form-item>
        <el-form-item v-if="status=='modify'">
          <el-button type="primary" @click="updateInfo">保存</el-button>
          <el-button type="primary" @click="backToView">取消</el-button>
        </el-form-item>
        <el-form-item>
          <el-button type="warning" @click="addBalance">充值使我变强</el-button>
        </el-form-item>
      </el-form>
      <el-dialog title="充值使我变强" :visible.sync="dialogFormVisible">
        <el-form>
          <el-form-item>
            <el-row>
              <el-button type="warning" @click="setAmounts(68)" icon="el-icon-ice-cream-square">￥68</el-button>
              <el-button type="warning" @click="setAmounts(128)" icon="el-icon-ice-cream-round">￥128</el-button>
              <el-button type="warning" @click="setAmounts(328)" icon="el-icon-ice-cream">￥328</el-button>
              <el-button type="warning" @click="setAmounts(648)" icon="el-icon-dessert">￥648</el-button>
            </el-row>
          </el-form-item>
        </el-form>
        <el-row type="flex" justify="end">
          <el-button type="warning" @click="commitAddBalance" :disabled="commitBalance" icon="icon-rate-face-3">充 值</el-button>
          <el-button type="info" @click="dialogFormVisible = false">取 消</el-button>
        </el-row>
      </el-dialog>
    </div>
  </div>
</template>
<script>
  export default {
    data() {
      return {
        customerInfo: {
          name: "666",
          phoneNumber: "",
          balance: "22.20",
        },
        accountInfo: {
          username: "",
          nickname: "",
          sourcePwd: "",
          newPwd: "",
          checkPwd:""
        },
        status: "view",
        listLoading: false,
        dialogFormVisible: false,
        modifiable: true,
        addBalances:{
          amounts: "",
        },
        commitBalance: true,
      }
    },
    created() {
      this.getInfo();
    },
    methods: {
      getInfo(){
        if (!this.hasPerm('customerInfo:list')) {
          return
        }
        this.listLoading = true;
        this.api({
          url: "/customer/getInfo",
          method: "get",
        }).then(data => {
          this.listLoading = false;
          if(data!=null)
          this.customerInfo = data;
        })
      },
      toModifyInfo(){
        this.status="modify";
        this.modifiable=false;
      },
      backToView(){
        this.status="view";
        this.modifiable=true;
        this.getInfo();
      },
      commitAddBalance(){
          this.api({
          url: "/customer/addBalance",
          method: "post",
          data: this.addBalances,
        }).then(() => {
          this.getInfo();
          this.dialogFormVisible=false;
          this.$message.success("充值成功");
        })
      },
      addBalance(){
        // this.$message.error("还不能变强");
        this.dialogFormVisible=true;
        this.commitBalance=true;
      },
      updateInfo(){
      //更新Customer信息 
        this.api({
          url: "/customer/updateInfo",
          method: "post",
          data: this.customerInfo
        }).then(() => {
          this.getInfo();
          this.backToView();
          this.$message.success("更新成功");
        })
      },
      setAmounts(amounts){
        this.addBalances.amounts=amounts;
        this.commitBalance=false;
      },
      showModifyAccount(){
        
      }
    }
  }
</script>
