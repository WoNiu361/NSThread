
//.h文件
#define MySingletonH + (instancetype)sharedInstance;


// .m文件
#define MySingletonM \
static id _instace; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
return _instace; \
} \
\
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [[self alloc] init]; \
}); \
return _instace; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instace; \
}

/*
 宏，只默认认识一行文件，换行的话，不予识别，所以要换行，就要加个 \
 但是最后一行不要加，否则他会认为你后面还有，但是事实上已经没有了。
 */
