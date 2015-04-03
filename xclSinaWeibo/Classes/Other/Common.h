//
//  Common.h
//  xclSinaWeibo
//
//  Created by xiechanglei on 15/4/2.
//  Copyright (c) 2015年 谢长磊. All rights reserved.
//

#ifndef xclSinaWeibo_Common_h
#define xclSinaWeibo_Common_h


//1. 判断是否为iPhone5  注意   只要是结果  那么在做宏定义的时候  一定要加 括号
#define isIphone5  ([UIScreen mainScreen].bounds.size.height == 568)

//2.日志输出宏定义
#ifdef DEBUG
//调试状态   __VA_ARGS__      可变参数宏__VA_ARGS__      https://www.baidu.com/s?wd=__VA_ARGS__&rsv_spt=1&issp=1&f=8&rsv_bp=1&rsv_idx=2&ie=utf-8&tn=baiduhome_pg&rsv_enter=0&rsv_pq=ece7b4470002f592&rsv_t=f833UWTy%2BKNNuNVO1e1HEpa8E8LHjqyZL%2FbV6aLQma7JXmIBXPRFvpwjSnxxHqnTVU2a&inputT=2349&rsv_sug3=5&bs=zbarsdk官网     缺省号代表一个可以变化的参数表。使用保留名 __VA_ARGS__ 把参数传递给宏。当宏的调用展开时，实际的参数就传递给 MyLog()了


#define MyLog(...) NSLog(__VA_ARGS__)

#else 
//发布状态   MyLog(...) 后面什么都不写
#define MyLog(...)

#endif



#endif
