import Vue from 'vue'
import Router from 'vue-router'
// in development env not use Lazy Loading,because Lazy Loading too many pages will cause webpack hot update too slow.so only in production use Lazy Loading
/* layout */
import Layout from '../views/layout/Layout'

const _import = require('./_import_' + process.env.NODE_ENV)
Vue.use(Router)
export const constantRouterMap = [
  {path: '/login', component: _import('login/index'), hidden: true},
  // {path: '/cRegister', component: _import('register/customer'), hidden: true},
  // {path: '/bRegister', component: _import('register/business'), hidden: true},
  {path: '/404', component: _import('404'), hidden: true},
  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    name: '首页',
    hidden: true,
    children: [{
      path: 'dashboard', component: _import('dashboard/index')
    }]
  }
]
export default new Router({
  // mode: 'history', //后端支持可开
  scrollBehavior: () => ({y: 0}),
  routes: constantRouterMap
})
export const asyncRouterMap = [
  {
    path: '/system',
    component: Layout,
    redirect: '/system/article',
    name: '功能模块',
    meta: {title: '功能模块', icon: 'tree'},
    children: [
      {
        path: 'article',
        name: '文章',
        component: _import('article/article'),
        meta: {title: '文章', icon: 'example'},
        menu: 'article'
      },
      {
        path: 'order',
        name: '订单',
        component: _import('order/order'),
        meta: {title: '订单', icon: 'example'},
        menu: 'order'
      },
      {
        path: 'businessInfo',
        name: '商家信息',
        component: _import('information/business'),
        meta: {title: '商家信息', icon: 'example'},
        menu: 'businessInfo'
      },
      {
        path: 'goodsCategory',
        name: '类目管理',
        component: _import('information/business/goodsCategory'),
        meta: {title: '类目管理', icon: 'example'},
        menu: 'goodsCategory'
      },
      {
        path: 'goodsManage',
        name: '商品管理',
        component: _import('information/business/goodsManage'),
        meta: {title: '商品管理', icon: 'example'},
        menu: 'goodsManage'
      },
      {
        path: 'viewGoods',
        name: '商品浏览',
        component: _import('information/customer/viewGoods'),
        meta: {title: '商品浏览', icon: 'example'},
        menu: 'viewGoods'
      },
      {
        path: 'customerInfo',
        name: '顾客信息',
        component: _import('information/customer'),
        meta: {title: '顾客信息', icon: 'example'},
        menu: 'customerInfo'
      },
      {
        path: 'viewBusiness',
        name: '浏览商家信息',
        component: _import('information/customer/viewBusiness'),
        meta: {title: '浏览商家信息', icon: 'example'},
        menu: 'viewBusiness',
        hidden: true,
      },
    ]
  },
  {
    path: '/user',
    component: Layout,
    redirect: '/user/',
    name: '',
    meta: {title: '用户权限', icon: 'table'},
    children: [
      {
        path: '', 
        name: '用户列表', 
        component: _import('user/user'), 
        meta: {title: '用户列表', icon: 'user'}, 
        menu: 'user'
      },
      {
        path: 'role',
        name: '权限管理',
        component: _import('user/role'),
        meta: {title: '权限管理', icon: 'password'},
        menu: 'role'
      },
      {
        path: 'pageTable',
        name: '菜单管理',
        component: _import('pageTable/pageTable'),
        meta: {title: '菜单管理', icon: 'password'},
        menu: 'pageTable'
      },
    ]
  },
  {path: '*', redirect: '/404', hidden: true}
]
