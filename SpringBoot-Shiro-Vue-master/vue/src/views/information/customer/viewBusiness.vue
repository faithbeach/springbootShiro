<template>
  <div class="app-container">
    <div>
      <el-form ref="businessInfo" :model="businessInfo" label-width="100px" style='width: 700px; margin-left:50px;' :disabled="modifiable">
        <div>
        <el-form-item label="店铺姓名" style="width: 300px;" prop="name">    
          <el-input v-model="businessInfo.name"></el-input>
        </el-form-item>
        <el-form-item label="联系电话" style="width: 300px;" prop="phoneNumber">    
          <el-input v-model="businessInfo.phoneNumber"></el-input>
        </el-form-item>
        <el-form-item label="商铺地址" style="width: 300px;" prop="address">
          <el-input v-model="businessInfo.address"></el-input>
        </el-form-item>
        <el-form-item label="营业时间段" prop="openTime">
          <el-time-select placeholder="开始营业时间" v-model="businessInfo.openTime" 
             :picker-options="{
              start: '05:00',
              step: '00:10',
              end: '23:59'
            }"></el-time-select>
          <el-time-select placeholder="结束营业时间" v-model="businessInfo.closeTime" 
             :picker-options="{
              start: '05:00',
              step: '00:10',
              end: '23:59',
              minTime: businessInfo.openTime
            }"></el-time-select>
        </el-form-item>
        <el-form-item label="商铺简介" style="width: 300px;" prop="brief">
          <el-input v-model="businessInfo.brief" type="textarea" :rows="4"></el-input>
        </el-form-item>
        </div>
        </el-form>
    </div>
  </div>
</template>
<script>
  export default {
    data() {
      return {
        businessInfo: {
          name: "还没有名字",
          phoneNumber: "还没给电话",
          address: "还没留地址",
          brief: "莫得简介",
          openTime: "08:30",
          closeTime: '10:00',
        },
        accountInfo: {
          username: "",
          nickname: "",
          sourcePwd: "",
          newPwd: "",
          checkPwd:""
        },
        msg:{
          msgBusinessId: 10010,
        },
        status: "view",
        listLoading: false,
        dialogFormVisible: false,
        modifiable: true,
      }
    },
    created() {
      this.msg.msgBusinessId = this.$route.params.msgId;
      this.getInfo();
    },
    methods: {
      getInfo(){
        if (!this.hasPerm('viewBusiness:list')) {
          return
        }
        this.listLoading = true;
        this.api({
          url: "/viewBusiness/getBusinessById",
          method: "get",
          params: this.msg,
        }).then(data => {
          this.listLoading = false;
          if(data!=null)
          this.businessInfo = data;
        })
      },
      toModifyInfo(){
        this.status="modify";
        this.modifiable=false;
      },
      backToView(){
        // this.resetForm('businessInfo');
        this.status="view";
        this.modifiable=true;
        this.getInfo();
      },
      showModifyAccount(){
        this.$message.err("暂未添加此功能。")
      },
      addBalance(){
        // this.$message.error("还不能变强");
        this.$message.success("成功");
      },
      updateInfo(){
        // this.$refs['businessInfo'].validate((valid) =>{
        //   if(valid) {
            this.api({
              url: "/business/updateInfo",
              method: "post",
              data: this.businessInfo
            }).then(() => {
              this.getInfo();
              this.backToView();
              this.$message.success("更新成功");
            })
        //   } else {
        //     this.$message.err("请填完必须信息");
        //     return false;
        //   }
        // })
      },
      // resetForm(formName){
      //   this.$refs[formName].resetFields();
      // },
    }
  }
</script>
