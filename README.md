# FMDataVersion 数据库迭代更新流程验证
1.第一次安装程序的时候注释VersonManager中的case 2和case 3 （因为刚发版肯定都是第一次安装）
2.点击添加数据，所有的数据只添加了name,和gender两个字段，
3.此时模拟版本更新，打开case 2 或者case3也打开，此时读取数据，元数据中的地址userAddress都是空的，但是之前加的name,gender都是有值
5.更新数据，给之前的数据赋值
