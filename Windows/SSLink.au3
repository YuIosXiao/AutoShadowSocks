#cs
	[Au3_Compiler]
	ICON=
	Export=z:\ss.au3
	Output=
	StripCode=1
	SafeFuncName=0
	MaxProtect=1
	Console=0
	VMP=0
	UPX=0
#ce

; ///////////////////////////////////////////////////////////////////////////
; ///////////////////////////////////// 警告 ////////////////////////////////
; //// 由于AU3对UTF8和指针并不友好，所以转码部分由DLL完成，并且没有释  //////
; //// 放对应内存，考虑到问题不大（几百字节的内存泄漏）所以暂时不作处理 /////
; //// 有洁癖的可以自行调用SCFree释放UTF8转换后的内存 ///////////////////////
; ///////////////////////////////////////////////////////////////////////////

#NoTrayIcon
#include "SSLinkerUI.au3"

Global Const $szConfig = StringFormat('%s\\SSLink.ini', @AppDataDir)

If (0 == @Compiled) Then
;~ Global Const $szHelper = 'D:\Software\Git\sma11caseW\Compiled\Debug\sma11case.dll'
	Global Const $szHelper = 'D:\Software\Git\sma11caseW\Compiled\Release\sma11case.dll'
Else
	Global Const $szHelper = StringFormat('%s\\SSLink.dll', @ScriptDir)
EndIf

Global Const $szWorkdir = @TempDir
Global Const $szValidConfig = StringFormat('%s\\valid.ini', $szWorkdir)
Global Const $szMyConfig = StringFormat('%s\\servers.ini', $szWorkdir)
Global Const $szCookies = StringFormat('%s\\SSLink.txt', $szWorkdir)

Static Global $hHelper = 0

init()

While 1
	Sleep(100)
WEnd

Exit

Func apiWorking($v0 = 0, $v1 = 0, $v2 = 0, $v3 = 0, $v4 = 0, $v5 = 0, $v6 = 0, $v7 = 0, $v8 = 0, $v9 = 0, $v10 = 0)
	Local $aTemp = 0
	
	Static Local $busyGUI = GUICreate('SSLinker', 320, 240, -1, -1, BitOR($WS_SYSMENU, $WS_POPUP), -1, $SSLinker)
	GUISetState(@SW_SHOW, $busyGUI)
	
	GUISetFont(11, 400, 0, "新宋体")
	GUICtrlCreateLabel('working ... please wait ....', 0, 100, 240, 60, $ES_CENTER)
	
	Switch @NumParams
		Call 0
		Case 1
		Case 2
		Case 3
			$aTemp = DllCall($v0, $v1, $v2)
		Case 4
			$aTemp = DllCall($v0, $v1, $v2, $v3)
		Case 5
			$aTemp = DllCall($v0, $v1, $v2, $v3, $v4)
		Case 6
			$aTemp = DllCall($v0, $v1, $v2, $v3, $v4, $v5)
		Case 7
			$aTemp = DllCall($v0, $v1, $v2, $v3, $v4, $v5, $v6)
		Case 8
			$aTemp = DllCall($v0, $v1, $v2, $v3, $v4, $v5, $v6, $v7)
		Case 9
			$aTemp = DllCall($v0, $v1, $v2, $v3, $v4, $v5, $v6, $v7, $v8)
		Case 10
			$aTemp = DllCall($v0, $v1, $v2, $v3, $v4, $v5, $v6, $v7, $v8, $v9)
		Case 11
			$aTemp = DllCall($v0, $v1, $v2, $v3, $v4, $v5, $v6, $v7, $v8, $v9, $v10)
	EndSwitch
	Local $nError = @error
	Local $nExtend = @extended
	
	GUISetState(@SW_HIDE, $busyGUI)

	Return SetError($nError, $nExtend, $aTemp)
EndFunc   ;==>apiWorking

Func setDisable($nTemp)
	GUICtrlSetState($nTemp, 128)
EndFunc   ;==>setDisable

Func setEnable($nTemp)
	GUICtrlSetState($nTemp, 64)
EndFunc   ;==>setEnable

Func init()
	Local $szUser = IniRead($szConfig, 'userInfo', 'user', '')
	Local $szPWD = IniRead($szConfig, 'userInfo', 'password', '')
	If ($szUser) Then
		GUICtrlSetState($c_remember, 1)
		GUICtrlSetData($i_user, $szUser)
		If ($szPWD) Then GUICtrlSetData($i_password, $szPWD)
	EndIf
	
	Local $szMyConfigenHost = IniRead($szConfig, 'listenInfo', 'host', '')
	Local $szMyConfigenPort = IniRead($szConfig, 'listenInfo', 'port', '')
	If ($szMyConfigenHost) Then GUICtrlSetData($i_listenHost, $szMyConfigenHost)
	If ($szMyConfigenPort) Then GUICtrlSetData($i_listenPort, $szMyConfigenPort)
	
	$hHelper = DllOpen($szHelper)
EndFunc   ;==>init

Func b_buyClick()
	setDisable($b_buy)
	
	Local $aTemp = 0
	Local $szName = GUICtrlRead($l_buyList)
	If ($szName) Then
		$szName = IniRead($szValidConfig, $szName, 'name', '')
		$aTemp = apiWorking($hHelper, 'str:cdecl', 'ANSIToUTF8', 'str', $szName)
		$szName = $aTemp[0]
		If ($szName) Then $aTemp = apiWorking($hHelper, 'long', 'ss_buyServer', 'str', $szCookies, 'str', $szName)
	EndIf
	
	If (IsArray($aTemp) And $aTemp[0]) Then
		b_freshListClick()
		createLastHosting()
	Else
		MsgBox(0, 'buy state', 'buy failed, please retry', 0, $SSLinker)
	EndIf
	
	setEnable($b_buy)
EndFunc   ;==>b_buyClick

Func createLastHosting()
	Local $aTemp = IniReadSectionNames($szMyConfig)
	If (@error Or 0 == $aTemp[0]) Then Return
	
	Local $szHostingId = '0'
	For $a = 1 To $aTemp[0]
		Local $szTemp = $aTemp[$a]
		
		Local $szPassword = IniRead($szMyConfig, $szTemp, 'password', '')
		If ($szPassword) Then ContinueLoop
		
		Local $szBuffer = IniRead($szMyConfig, $szTemp, 'hostingId', '')
		
		If (Number($szBuffer, 1) > Number($szHostingId, 1)) Then $szHostingId = $szBuffer
	Next
	
	Local $aTemp = apiWorking($hHelper, 'long', 'ss_createHosting', 'str', $szCookies, 'str', $szHostingId)
	
	If (0 == $aTemp[0]) Then MsgBox(0, 'create host', 'create hosting failed, use [create hosting] button to try')
	
	b_freshListClick()
EndFunc   ;==>createLastHosting

; typedef void(*SSValidServersCallback)(long index, SSServerInfo *info, ptrparam);
Func SSValidServersCallback($index, $info, $param)
	Local $tTemp = DllStructCreate('ptr name;ptr host', $info)
	
	Local $t1 = DllStructGetData($tTemp, 1)
	Local $t2 = DllStructGetData($tTemp, 2)
	
	Local $aTemp = DllCall($hHelper, 'wstr:cdecl', 'UTF8ToUnicode', 'ptr', $t1)
	Local $szName = $aTemp[0]
	
	Local $aTemp = DllCall($hHelper, 'wstr:cdecl', 'UTF8ToUnicode', 'ptr', $t2)
	Local $szHost = $aTemp[0]
	
	If ($szName And $szHost) Then
		Local $szTemp = StringFormat('<%ld> %-15s @ %s', $index, $szHost, $szName)
		GUICtrlSetData($l_buyList, $szTemp)
		IniWrite($szValidConfig, $szTemp, 'name', $szName)
		IniWrite($szValidConfig, $szTemp, 'host', $szHost)
	EndIf
EndFunc   ;==>SSValidServersCallback

Func b_freshBuyClick()
	setDisable($b_buy)
	setDisable($b_freshBuy)
	GUICtrlSetData($l_buyList, '')
	FileDelete($szValidConfig)
	
	Local $fCallback = DllCallbackRegister('SSValidServersCallback', 'long', 'long;ptr;ptr')
	Local $pCallback = DllCallbackGetPtr($fCallback)
	Local $aTemp = apiWorking($hHelper, 'long', 'ss_getValidServers', 'ptr', Null, 'ptr', $pCallback)
	DllCallbackFree($fCallback)
	
	setEnable($b_freshBuy)
EndFunc   ;==>b_freshBuyClick

; typedef void(*SSMyServersCallback)(long index, SSLinkInfo *info, ptrparam);
Func SSMyServersCallback($index, $info, $param)
	Local $tTemp = DllStructCreate('ptr hostingId;ptr host;ptr password;ptr method;ptr port;ptr expireTime;ptr comment', $info)
	
	Local $t1 = DllStructGetData($tTemp, 1)
	Local $t2 = DllStructGetData($tTemp, 2)
	Local $t3 = DllStructGetData($tTemp, 3)
	Local $t4 = DllStructGetData($tTemp, 4)
	Local $t5 = DllStructGetData($tTemp, 5)
	Local $t6 = DllStructGetData($tTemp, 6)
	Local $t7 = DllStructGetData($tTemp, 7)
	
	If ($t3) Then
		Local $aTemp = DllCall($hHelper, 'wstr:cdecl', 'UTF8ToUnicode', 'ptr', $t7)
		Local $szName = $aTemp[0]
		
		Local $aTemp = DllCall($hHelper, 'wstr:cdecl', 'UTF8ToUnicode', 'ptr', $t1)
		Local $szHostingId = $aTemp[0]
		
		If ($szName And $szHostingId) Then
			Local $aTemp = DllCall($hHelper, 'wstr:cdecl', 'UTF8ToUnicode', 'ptr', $t3)
			Local $szPassword = $aTemp[0]
			
			If ($szPassword) Then
				Local $aTemp = DllCall($hHelper, 'wstr:cdecl', 'UTF8ToUnicode', 'ptr', $t2)
				Local $szHost = $aTemp[0]
				
				Local $szTemp = StringFormat('<%ld> %-15s @ %s', $index, $szHost, $szName)
				GUICtrlSetData($l_myList, $szTemp)
				
				Local $aTemp = DllCall($hHelper, 'wstr:cdecl', 'UTF8ToUnicode', 'ptr', $t5)
				Local $szPort = $aTemp[0]
				
				Local $aTemp = DllCall($hHelper, 'wstr:cdecl', 'UTF8ToUnicode', 'ptr', $t4)
				Local $szMethod = $aTemp[0]
				
				Local $aTemp = DllCall($hHelper, 'wstr:cdecl', 'UTF8ToUnicode', 'ptr', $t6)
				Local $szExpireTime = $aTemp[0]
				
				IniWrite($szMyConfig, $szTemp, 'hostingId', $szHostingId)
				IniWrite($szMyConfig, $szTemp, 'name', $szName)
				IniWrite($szMyConfig, $szTemp, 'host', $szHost)
				IniWrite($szMyConfig, $szTemp, 'port', $szPort)
				IniWrite($szMyConfig, $szTemp, 'password', $szPassword)
				IniWrite($szMyConfig, $szTemp, 'method', $szMethod)
				IniWrite($szMyConfig, $szTemp, 'expireTime', $szExpireTime)
			Else
				Local $szTemp = StringFormat('<%ld> <notwork:%s> %s', $index, $szHostingId, $szName)
				GUICtrlSetData($l_myList, $szTemp)
				IniWrite($szMyConfig, $szTemp, 'hostingId', $szHostingId)
				IniWrite($szMyConfig, $szTemp, 'name', $szName)
			EndIf
			
			
		EndIf
	EndIf
EndFunc   ;==>SSMyServersCallback

Func b_freshListClick()
	setDisable($b_createHosting)
	setDisable($b_selected)
	setDisable($b_test)
	setDisable($b_freshList)
	GUICtrlSetData($l_myList, '')
	FileDelete($szMyConfig)
	
	Local $fCallback = DllCallbackRegister('SSMyServersCallback', 'long', 'long;ptr;ptr')
	Local $pCallback = DllCallbackGetPtr($fCallback)
	apiWorking($hHelper, 'long', 'ss_getMyServers', 'str', $szCookies, 'ptr', Null, 'ptr', $pCallback)
	DllCallbackFree($fCallback)
	
	setEnable($b_freshList)
EndFunc   ;==>b_freshListClick

Func b_registerClick()
	Switch Random(0, 2, 1)
		Case 0
			ShellExecute('http://www.ss-link.com/register')
			
		Case 1
			ShellExecute('http://www1.ss-link.com/register')
			
		Case 2
			ShellExecute('http://www2.ss-link.com/register')
	EndSwitch
EndFunc   ;==>b_registerClick

Func b_loginClick()
	setDisable($b_login)
	setDisable($i_user)
	setDisable($i_password)
	
	Local $szUser = GUICtrlRead($i_user)
	Local $szPWD = GUICtrlRead($i_password)
	
	If ($szUser And $szPWD) Then
		Local $aTemp = apiWorking($hHelper, 'long', 'ss_login', 'str', $szCookies, 'str', $szUser, 'str', $szPWD)
		If ($aTemp[0]) Then
			b_freshBuyClick()
			b_freshListClick()
			Return
		EndIf
	EndIf
	
	setEnable($b_login)
	setEnable($i_user)
	setEnable($i_password)
EndFunc   ;==>b_loginClick

Func b_createHostingClick()
	setDisable($b_createHosting)
	
	Local $szTemp = GUICtrlRead($l_myList)
	Local $szHostingId = IniRead($szMyConfig, $szTemp, 'hostingId', '')
	apiWorking($hHelper, 'long', 'ss_createHosting', 'str', $szCookies, 'str', $szHostingId)
	setEnable($b_createHosting)
	
	b_freshListClick()
EndFunc   ;==>b_createHostingClick

Func b_selectedClick()
	setDisable($b_selected)
	
	Local $szHost = GUICtrlRead($i_serverHost)
	Local $szPort = GUICtrlRead($i_serverPort)
	Local $szPassword = GUICtrlRead($i_serverPassword)
	Local $szMethod = GUICtrlRead($i_method)
	
	Local $szMyConfigenHost = GUICtrlRead($i_listenHost)
	Local $szMyConfigenPort = GUICtrlRead($i_listenPort)

	Local $szTemp = StringFormat('shadowsocks-local.exe -s=%s -k=%s -p=%s -b=%s -l=%s -m=%s', $szHost, $szPassword, _
			$szPort, $szMyConfigenHost, $szMyConfigenPort, $szMethod)
	ProcessClose('shadowsocks-local.exe')
	Run($szTemp, @ScriptDir, @SW_HIDE, 0x10000)
EndFunc   ;==>b_selectedClick

Func c_rememberClick()
	Local $nState = GUICtrlRead($c_remember)

	If (1 == $nState) Then
		IniWrite($szConfig, 'userInfo', 'user', GUICtrlRead($i_user))
		IniWrite($szConfig, 'userInfo', 'password', GUICtrlRead($i_password))
		Return
	EndIf
	
	IniDelete($szConfig, 'userInfo')
EndFunc   ;==>c_rememberClick

Func i_listenHostChange()
	Local $szMyConfigenHost = GUICtrlRead($i_listenHost)
	IniWrite($szConfig, 'listenInfo', 'host', $szMyConfigenHost)
EndFunc   ;==>i_listenHostChange

Func i_listenPortChange()
	Local $szMyConfigenPort = GUICtrlRead($i_listenPort)
	IniWrite($szConfig, 'listenInfo', 'port', $szMyConfigenPort)
EndFunc   ;==>i_listenPortChange

Func i_methodChange()

EndFunc   ;==>i_methodChange

Func i_passwordChange()
	c_rememberClick()
EndFunc   ;==>i_passwordChange

Func i_serverHostChange()

EndFunc   ;==>i_serverHostChange

Func i_serverPasswordChange()

EndFunc   ;==>i_serverPasswordChange

Func i_serverPortChange()

EndFunc   ;==>i_serverPortChange

Func i_userChange()
	c_rememberClick()
EndFunc   ;==>i_userChange

Func l_buyListClick()
	setEnable($b_buy)
EndFunc   ;==>l_buyListClick

Func l_myListClick()
	setDisable($b_selected)
	setDisable($b_test)
	setDisable($b_createHosting)
	
	Local $szBuffer = GUICtrlRead($l_myList)
	If ('' == $szBuffer) Then Return
	
	Local $szHost = IniRead($szMyConfig, $szBuffer, 'host', '')
	Local $szPort = IniRead($szMyConfig, $szBuffer, 'port', '')
	Local $szPassword = IniRead($szMyConfig, $szBuffer, 'password', '')
	Local $szMethod = IniRead($szMyConfig, $szBuffer, 'method', '')
	Local $szExpireTime = IniRead($szMyConfig, $szBuffer, 'expireTime', '')
	
	GUICtrlSetData($i_serverHost, $szHost)
	GUICtrlSetData($i_serverPassword, $szPassword)
	GUICtrlSetData($i_serverPort, $szPort)
	GUICtrlSetData($i_method, $szMethod)
	GUICtrlSetData($i_expireTime, $szExpireTime)

	If ($szPassword) Then
		setEnable($b_selected)
		setEnable($b_test)
	Else
		setEnable($b_createHosting)
	EndIf
EndFunc   ;==>l_myListClick

Func SSLinkerClose()
	DllClose($hHelper)
	Exit
EndFunc   ;==>SSLinkerClose

Func SSLinkerMaximize()

EndFunc   ;==>SSLinkerMaximize

Func SSLinkerMinimize()

EndFunc   ;==>SSLinkerMinimize

Func SSLinkerRestore()

EndFunc   ;==>SSLinkerRestore

Func b_testClick()
	setDisable($b_test)
	b_selectedClick()
	
	Local $szHost = GUICtrlRead($i_listenHost)
	Local $nPort = GUICtrlRead($i_listenPort) + 0
	Local $aTemp = apiWorking($hHelper, 'long', 'ss_verifyProxy', 'str', 'https://www.google.com/?gws_rd=ssl&safe=off', 'str', $szHost, 'short', $nPort)
	
	If ($aTemp[0]) Then
		MsgBox(0, 'proxy tester', 'reachabled', 0, $SSLinker)
	Else
		MsgBox(0, 'proxy tester', 'unreachabled', 0, $SSLinker)
	EndIf
EndFunc   ;==>b_testClick

Func b_aboutClick()
	MsgBox(0, '这是一个标题', _
			'此程序仅供学习研究之用，' & @CRLF & _
			'不得用于其它用途，' & @CRLF & _
			'一切使用后果自负！ ' & @CRLF & _
			@CRLF & @CRLF & _
			'github: https://github.com/qokelate' & @CRLF & _
			'email: udf.q@qq.com', 0, $SSLinker)
EndFunc   ;==>b_aboutClick

Func b_donateClick()
	MsgBox(64, '哎呦，点到啥了', '好吧，我知道你是不小心踩到鼠标了', 0, $SSLinker)
EndFunc   ;==>b_donateClick

#cs
	Global $b_about = GUICtrlCreateButton("about", 121, 221, 105, 35)
	Global $b_buy = GUICtrlCreateButton("buy", 378, 40, 75, 35)
	Global $b_createHosting = GUICtrlCreateButton("create hosting", 863, 28, 135, 35)
	Global $b_donate = GUICtrlCreateButton("donate", 28, 221, 90, 35)
	Global $b_freshBuy = GUICtrlCreateButton("fresh", 270, 40, 75, 35)
	Global $b_freshList = GUICtrlCreateButton("fresh", 670, 50, 75, 35)
	Global $b_login = GUICtrlCreateButton("login", 120, 151, 105, 35)
	Global $b_register = GUICtrlCreateButton("register", 27, 151, 90, 35)
	Global $b_selected = GUICtrlCreateButton("use", 761, 50, 75, 35)
	Global $b_test = GUICtrlCreateButton("use && test", 863, 70, 135, 35)
	Global $c_remember = GUICtrlCreateCheckbox("remember me", 70, 120, 137, 17)
	Global $Group1 = GUICtrlCreateGroup("login info", 20, 10, 215, 185)
	Global $Group2 = GUICtrlCreateGroup("service info", 20, 270, 215, 225)
	Global $Group3 = GUICtrlCreateGroup("buy list", 240, 10, 375, 485)
	Global $Group4 = GUICtrlCreateGroup("server list", 640, 10, 375, 485)
	Global $Group5 = GUICtrlCreateGroup("follow me", 20, 200, 215, 65)
	Global $i_expireTime = GUICtrlCreateInput("expire time", 39, 462, 181, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
	Global $i_listenHost = GUICtrlCreateInput("listen host", 40, 300, 181, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
	Global $i_listenPort = GUICtrlCreateInput("listen port", 40, 327, 181, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
	Global $i_method = GUICtrlCreateInput("server method", 40, 436, 181, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
	Global $i_password = GUICtrlCreateInput("password", 40, 70, 181, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_PASSWORD))
	Global $i_serverHost = GUICtrlCreateInput("server host", 40, 354, 181, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
	Global $i_serverPassword = GUICtrlCreateInput("password", 40, 409, 181, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
	Global $i_serverPort = GUICtrlCreateInput("server port", 40, 382, 181, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
	Global $i_user = GUICtrlCreateInput("username", 40, 30, 181, 23, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
	Global $l_buyList = GUICtrlCreateList("", 260, 90, 340, 381, BitOR($LBS_NOTIFY,$WS_VSCROLL,$WS_BORDER))
	Global $l_myList = GUICtrlCreateList("", 660, 110, 340, 366, BitOR($LBS_NOTIFY,$WS_VSCROLL,$WS_BORDER))
	Global $SSLinker = GUICreate("SSLinker
#ce
