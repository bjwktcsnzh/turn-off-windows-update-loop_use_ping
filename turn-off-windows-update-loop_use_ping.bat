@echo off
title turnoff_windows_autoupdate_loopinnnnng


echo +-----------------------------------------------------------+
echo;
echo .   此为自启的关闭windows自动更新批处理文件
echo;
echo .  .  .  .  . %date%%time% .  .  .  .  .  .  .
echo;
cd /d "%~dp0"
echo .  当前目录:%cd%
echo;
echo +-----------------------------------------------------------+
echo .
echo .
echo .  正在获取管理员权限...
echo .
echo .
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
color 09
echo +-----------------------------------------------------------+
echo . 
echo test time:	%date%	%time%>>turn-off-windows-update-record-loop.log
echo . 
echo .   
echo .   
echo .   正在检查如下有关windows10自动更新的服务是否停止:
echo .   
echo .   
echo .
echo .           Background Intelligent Transfer Service  
echo .           Delivery Optimization                              
echo .           Windows Update
echo .           Windows Update Medic Service
echo .           Windows 推送通知系统服务
echo .
echo .
echo +-----------------------------------------------------------+
echo;
echo .    在该批处理目录下的
echo .    turn-off-windows-update-record-loop.log文件中
echo .    记录了历次测试信息
echo;
echo +-----------------------------------------------------------+
:returncheck
set flag=ture


for /f "skip=3 tokens=4" %%i in ('sc query "BITS"') do set "zt=%%i" &goto :next 
 :next 
 if /i "%zt%"=="RUNNING" ( 
net stop "Background Intelligent Transfer Service" 
set flag=ture
echo 	%date%	%time%	Service -- "BITS" -- "Background Intelligent Transfer Service" -- is running !>>turn-off-windows-update-record-loop.log
) else ( 
echo .   服务Background Intelligent Transfer Service已停止 
) 
echo;
echo +-----------------------------------------------------------+
for /f "skip=3 tokens=4" %%i in ('sc query "DoSvc"') do set "zt=%%i" &goto :next 
 :next 
 if /i "%zt%"=="RUNNING" ( 
net stop "Delivery Optimization"
set flag=ture
echo 	%date%	%time%	Service -- "DoSvc" -- "Delivery Optimization" -- is running !>>turn-off-windows-update-record-loop.log
) else ( 
echo .   服务Delivery Optimization已停止 
) 
echo;
echo +-----------------------------------------------------------+
for /f "skip=3 tokens=4" %%i in ('sc query "wuauserv"') do set "zt=%%i" &goto :next 
 :next 
 if /i "%zt%"=="RUNNING" ( 
net stop "Windows Update"
set flag=ture
echo 	%date%	%time%	Service -- "wuauserv" -- "Windows Update" -- is running !>>turn-off-windows-update-record-loop.log
) else ( 
echo .   服务Windows Update已停止 
) 
echo;
echo +-----------------------------------------------------------+
for /f "skip=3 tokens=4" %%i in ('sc query "WaaSMedicSvc"') do set "zt=%%i" &goto :next 
 :next 
 if /i "%zt%"=="RUNNING" ( 
net stop "Windows Update Medic Service" 
set flag=ture
echo 	%date%	%time%	Service -- "WaaSMedicSvc" -- "Windows Update Medic Service" -- is running !>>turn-off-windows-update-record-loop.log
) else ( 
echo .   服务Windows Update Medic Service已停止 
) 
echo;
echo +-----------------------------------------------------------+
for /f "skip=3 tokens=4" %%i in ('sc query "WpnService"') do set "zt=%%i" &goto :next 
 :next 
 if /i "%zt%"=="RUNNING" ( 
net stop "Windows 推送通知系统服务"
set flag=ture
echo 	%date%	%time%	Service -- "WpnService" -- "Windows 推送通知系统服务" -- is running !>>turn-off-windows-update-record-loop.log
) else ( 
echo .   服务Windows 推送通知系统服务已停止 
) 
echo;
echo +-----------------------------------------------------------+
if %flag%==ture (
echo;
echo;
echo;
echo;
echo;
echo;
echo +-----------------------------------------------------------+
echo .
echo .                 循环检查中.....
echo .                 
echo .                 等待15秒.....
echo .
echo +-----------------------------------------------------------+
ping /n 15 127.0.0.1>nul
goto :returncheck
)
echo;
echo;
echo;
echo +-----------------------------------------------------------+
echo .
echo .                 正在修改注册表...
echo .                 (尚未开发...不会写...)
echo .
echo +-----------------------------------------------------------+
echo;
echo;
echo;
echo;
echo                +--------------------------+
echo                +         检查结束         +
echo                +--------------------------+       
echo;
echo;
echo;
echo;
exit 
