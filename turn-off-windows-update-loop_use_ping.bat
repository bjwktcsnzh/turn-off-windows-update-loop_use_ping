@echo off
title turnoff_windows_autoupdate_loopinnnnng


echo +-----------------------------------------------------------+
echo;
echo .   ��Ϊ�����Ĺر�windows�Զ������������ļ�
echo;
echo .  .  .  .  . %date%%time% .  .  .  .  .  .  .
echo;
cd /d "%~dp0"
echo .  ��ǰĿ¼:%cd%
echo;
echo +-----------------------------------------------------------+
echo .
echo .
echo .  ���ڻ�ȡ����ԱȨ��...
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
echo .   ���ڼ�������й�windows10�Զ����µķ����Ƿ�ֹͣ:
echo .   
echo .   
echo .
echo .           Background Intelligent Transfer Service  
echo .           Delivery Optimization                              
echo .           Windows Update
echo .           Windows Update Medic Service
echo .           Windows ����֪ͨϵͳ����
echo .
echo .
echo +-----------------------------------------------------------+
echo;
echo .    �ڸ�������Ŀ¼�µ�
echo .    turn-off-windows-update-record-loop.log�ļ���
echo .    ��¼�����β�����Ϣ
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
echo .   ����Background Intelligent Transfer Service��ֹͣ 
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
echo .   ����Delivery Optimization��ֹͣ 
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
echo .   ����Windows Update��ֹͣ 
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
echo .   ����Windows Update Medic Service��ֹͣ 
) 
echo;
echo +-----------------------------------------------------------+
for /f "skip=3 tokens=4" %%i in ('sc query "WpnService"') do set "zt=%%i" &goto :next 
 :next 
 if /i "%zt%"=="RUNNING" ( 
net stop "Windows ����֪ͨϵͳ����"
set flag=ture
echo 	%date%	%time%	Service -- "WpnService" -- "Windows ����֪ͨϵͳ����" -- is running !>>turn-off-windows-update-record-loop.log
) else ( 
echo .   ����Windows ����֪ͨϵͳ������ֹͣ 
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
echo .                 ѭ�������.....
echo .                 
echo .                 �ȴ�15��.....
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
echo .                 �����޸�ע���...
echo .                 (��δ����...����д...)
echo .
echo +-----------------------------------------------------------+
echo;
echo;
echo;
echo;
echo                +--------------------------+
echo                +         ������         +
echo                +--------------------------+       
echo;
echo;
echo;
echo;
exit 
