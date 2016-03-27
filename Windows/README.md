## SSLinker for Windows 说明
1. 由于本人对Windows界面很不擅长,所以界面部分用AU3脚本实现,核心功能在 [https://github.com/qokelate/sma11caseW](https://github.com/qokelate/sma11caseW) 获得(C/C++).

2. AU3对UTF8和指针很不友好，所以转码功能由DLL完成并且没有及时释放对应内存(Au3处理指针比较麻烦),导致每次转码会引发几十字节内存泄漏,后面有空的话再做处理,有兴起的也可以自行处理.

3. `whitelist_socks5_1080.pac` 是配置好的GFWList,懂的都知道,不懂知不知道也没关系 ^_^
