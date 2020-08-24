;?; �ýű�ʹ�� HM VNISEdit �ű��༭���򵼲���

; ��װ�����ʼ���峣��
!define PRODUCT_NAME "2048Game"
!define CHINESE_NAME "2048��Ϸ"
!define PRODUCT_VERSION "1.0.0"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\${PRODUCT_NAME}.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_DRIVER_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\DemoForge Mirage Driver for TightVNC_is1"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
;�Լ����
!define PRODUCT_REINSTALL_KEY "Software\MicroRecording\MicroRecording-installer"
!define PRODUCT_AUTORUN_KEY "Software\Microsoft\Windows\CurrentVersion\Run"
!define PRODUCT_VERSION_KEY "Software\MicroRecording\MicroRecording"
;���ô����ö�
;!define MUI_PAGE_CUSTOMFUNCTION_SHOW Page_Show
SetCompressor lzma

!include "x64.nsh"

; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
!include "MUI.nsh"

; MUI Ԥ���峣��
;!define MUI_ABORTWARNING
!define MUI_ICON "setup.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; ����ѡ�񴰿ڳ�������
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; ��ӭҳ��
!insertmacro MUI_PAGE_WELCOME
; ���Э��ҳ��
;!insertmacro MUI_PAGE_LICENSE "licence.txt"
; ��װĿ¼ѡ��ҳ��
!insertmacro MUI_PAGE_DIRECTORY
; ��װ����ҳ��
!insertmacro MUI_PAGE_INSTFILES
; ��װ���ҳ��
!insertmacro MUI_PAGE_FINISH

; ��װж�ع���ҳ��
!insertmacro MUI_UNPAGE_INSTFILES

; ��װ�����������������
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "SimpChinese"

; ��װԤ�ͷ��ļ�
!insertmacro MUI_RESERVEFILE_LANGDLL
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI �ִ����涨����� ------
LangString CURLAN ${LANG_ENGLISH} "en"
LangString CURLAN ${LANG_SIMPCHINESE} "����"

LangString ProgLinkName ${LANG_SIMPCHINESE} ${CHINESE_NAME}
LangString ProgLinkName ${LANG_ENGLISH} "${PRODUCT_NAME}"

LangString UninstallBeforeInstall ${LANG_SIMPCHINESE} "��⵽ϵͳ�Ѿ���װ�� $(ProgLinkName)��$\r$\nж��֮ǰ�İ汾�Լ���?"
LangString UninstallBeforeInstall ${LANG_ENGLISH} "${PRODUCT_NAME} already installed $\r$\n we must uninstall it before continuing the setup. continue?"


LangString RuningTip ${LANG_SIMPCHINESE} "��⵽ $(ProgLinkName) ��������, �����˳�����Ȼ���ٳ���!"
LangString RuningTip ${LANG_ENGLISH} "Setup has detected ${PRODUCT_NAME} is running, please exit the program and try again!"

LangString UninstallSuccessTip ${LANG_SIMPCHINESE} "�Ѿ��ɹ�ж�� $(^Name)."
LangString UninstallSuccessTip ${LANG_ENGLISH} "$(^Name) has been successfully removed from your computer."

LangString UninstallConfirmTip ${LANG_SIMPCHINESE} "ȷ��ж�� $(^Name) �����������?"
LangString UninstallConfirmTip ${LANG_ENGLISH} "You really want to completely remove the $(^Name) , and all of its components?"


Name "${PRODUCT_NAME}${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME}${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
ShowInstDetails show
ShowUnInstDetails show

;���������Ҫ���ļ�
Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite try

  SetShellVarContext all
  CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\$(ProgLinkName).lnk" "$INSTDIR\${PRODUCT_NAME}.exe"
  CreateShortCut "$DESKTOP\$(ProgLinkName).lnk" "$INSTDIR\${PRODUCT_NAME}.exe"
  File /r ".\Setup\*"

  IfFileExists "$SYSDIR\msvcp120.dll" +2 0
  nsExec::Exec /TIMEOUT=3600000 "$INSTDIR\runtime\vcredist_x86_2013.exe /q"

SectionEnd

Section -AdditionalIcons
	SetShellVarContext all
  ;WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  ;CreateShortCut "$SMPROGRAMS\MicroRecording\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall.lnk" "$INSTDIR\uninst.exe"
  ; ����ǽ���������
  ;ExecDos::exec 'netsh advfirewall firewall add rule name="${PRODUCT_NAME}" dir=in program="$INSTDIR\${PRODUCT_NAME}.exe" action=allow'
  ;ExecDos::exec 'netsh advfirewall firewall add rule name="${PRODUCT_NAME}" dir=out program="$INSTDIR\${PRODUCT_NAME}.exe" action=allow'
  
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\${PRODUCT_NAME}.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\${PRODUCT_NAME}.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  ;WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_NAME}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_VERSION_KEY}" "CurrVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_VERSION_KEY}" "" "$INSTDIR"
  
SectionEnd

;���п��ж�����ϵͳλ�����а�װ
;Section
;  ${If} ${RunningX64}
;   //����Ϊ64Ϊ����ϵͳʱ��������Ӧ���ⲿ��װ����
;   ExecWait '"$INSTDIR\runtime\vc_redist2015.x64.exe" /quiet'
;   ExecWait '"$INSTDIR\runtime\vcredist2010_x64.exe" /quiet'
;  ${Else}
;   ExecWait '"$INSTDIR\runtime\vc_redist2015.x86.exe" /quiet'
;   ExecWait '"$INSTDIR\runtime\vcredist2010_x86.exe" /quiet'
;  ${EndIf}
;SectionEnd

;
;�����ǳ����ϰ汾�����д��
LangString SecCoreDesp ${LANG_SIMPCHINESE} "${CHINESE_NAME}"
LangString SecCoreDesp ${LANG_ENGLISH} "${PRODUCT_NAME}"

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SEC01} $(SecCoreDesp)
!insertmacro MUI_FUNCTION_DESCRIPTION_END


#-- ���� NSIS �ű��༭�������� Function ���α�������� Section ����֮���д���Ա��ⰲװ�������δ��Ԥ֪�����⡣--#

Function .onInit

	
  
   Pop $R0
   IntCmp $R0 1 0 no_run
   MessageBox MB_ICONSTOP $(RuningTip)
   Quit
   no_run:

  Push $0
  Push $1
  ReadRegStr $0 HKLM ${PRODUCT_UNINST_KEY} "UninstallString"
  StrCmp $0 "" onInit.End
  IfFileExists $0 0 onInit.End
  MessageBox MB_YESNO|MB_ICONQUESTION $(UninstallBeforeInstall) /SD IDYES IDNO onInit.GoAbort
  system::call 'Kernel32::GetModuleFileName(i 0,t .r1,i 256)i'
  WriteRegStr HKLM ${PRODUCT_REINSTALL_KEY} "" $1
  
  StrCpy $0 '"$0" /S'
	ExecWait $0
	Goto onInit.GoAbort
	
onInit.GoAbort:
    Abort
	onInit.End:
  Pop $1
  Pop $0

  !insertmacro MUI_LANGDLL_DISPLAY ;����ѡ����
;WriteRegStr HKCU "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\ffmpeg\ffmpeg.exe" "RUNASADMIN"
;WriteRegStr HKCU "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\HYEvaluate.exe" "RUNASADMIN"
;WriteRegStr HKCU "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\HyScreenRecord.exe" "RUNASADMIN"

FunctionEnd



/******************************
 *  �����ǰ�װ�����ж�ز���  *
 ******************************/


Section Uninstall

  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  RMDir /r "$INSTDIR"
  
    ;����ǽ����ɾ��
  ExecDos::exec 'netsh advfirewall firewall delete rule name="${PRODUCT_NAME}"'
  
  ;ɾ����ʼ�˵�������Ŀ�ݷ�ʽ
  SetShellVarContext all

  Delete "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall.lnk"
  ;Delete "$SMPROGRAMS\${PRODUCT_NAME}\Website.lnk"
  Delete "$DESKTOP\$(ProgLinkName).lnk"
  Delete "$SMPROGRAMS\${PRODUCT_NAME}\$(ProgLinkName).lnk"

  RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"
  
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  
  DeleteRegValue ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_AUTORUN_KEY}" "${PRODUCT_NAME}"
  DeleteRegKey HKLM "${PRODUCT_VERSION_KEY}"
  
  SetAutoClose true
SectionEnd

#-- ���� NSIS �ű��༭�������� Function ���α�������� Section ����֮���д���Ա��ⰲװ�������δ��Ԥ֪�����⡣--#

Function un.onInit

   FindProcDLL::FindProc "${PRODUCT_NAME}.exe"
   Pop $R0
   IntCmp $R0 1 0 no_run
   MessageBox MB_ICONSTOP $(RuningTip)
   Quit
   no_run:
!insertmacro MUI_UNGETLANGUAGE
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���������е������" IDYES +2
  Abort
  
  KillProcDLL::KillProc "MicroClassRecorder.exe"
  sleep 1000
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) �ѳɹ��ش����ļ�����Ƴ���"
  Push $0
  ReadRegStr $0 HKLM ${PRODUCT_REINSTALL_KEY} ""
  StrCmp $0 "" un.onUnEnd
  ReadRegStr $1 HKLM ${PRODUCT_REINSTALL_KEY} "params"
  StrCpy $0 '"$0" $1'
  Exec $0
  un.onUnEnd:
  DeleteRegKey HKLM ${PRODUCT_REINSTALL_KEY}
  Pop $0
FunctionEnd

;Function Page_Show
;StrCpy $0 $HWNDPARENT
;     System::Call "user32::SetWindowPos(i r0, i -1,i 0,i 0,i 0,i 0,i 3)"
;BringToFront

;FunctionEnd

/* Section "VCRedist2010" SecVC2010
  SetOutPath "$INSTDIR\runtime"
    SetOverwrite on
  SetCompress off
  File "runtime\dfmirage-setup-2.0.301.exe"
	Exec "$INSTDIR\runtime\dfmirage-setup-2.0.301.exe /q # silent install"
SectionEnd */
