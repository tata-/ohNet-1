# Makefile for Windows
#

!if "$(csplatform)"=="x64"
csplatform = x64
!else
csplatform = x86
!endif

!if "$(release)"=="1"
link_flag_debug = 
debug_specific_cflags = /MT /Ox
build_dir = Release
!else
link_flag_debug = /debug
debug_specific_cflags = /MTd /Zi /Od /RTC1
build_dir = Debug
!endif

# Macros used by Common.mak
ar = lib /nologo /out:$(objdir)
cflags_third_party = $(debug_specific_cflags) /W4 /EHsc /FR$(objdir) -DDEFINE_LITTLE_ENDIAN -DDEFINE_TRACE -D_CRT_SECURE_NO_WARNINGS
cflags = $(cflags_third_party) /WX
objdirbare = Build\Obj\Windows\$(build_dir)
objdir = $(objdirbare)^\
inc_build = Build\Include
includes = -IBuild\Include
bundle_build = Build\Bundles
osdir = Windows
objext = obj
libprefix = lib
libext = lib
sharedlibprefix = 
sharedlibext = lib
exeext = exe
compiler = cl /nologo /Fo$(objdir)
link = link /nologo $(link_flag_debug) /SUBSYSTEM:CONSOLE /map Ws2_32.lib Iphlpapi.lib Dbghelp.lib /incremental:no
linkoutput = /out:
dllprefix =
dllext = dll
linkopts_ohNet =
link_dll = link /nologo $(link_flag_debug) /map Ws2_32.lib Iphlpapi.lib Dbghelp.lib /dll
link_dll_service = link /nologo $(link_flag_debug)  /map $(objdir)ohNet.lib Ws2_32.lib Iphlpapi.lib Dbghelp.lib /dll
csharp = csc /nologo /platform:$(csplatform)
publicjavadir = OpenHome\Net\Bindings\Java^\
includes_jni = -I"$(JAVA_HOME)\include" -I"$(JAVA_HOME)\include\win32"
link_jvm = "$(JAVA_HOME)\lib\jvm.lib"
java_cflags = $(cflags)
javac =  "$(JAVA_HOME)\bin\javac.exe"
jar =  "$(JAVA_HOME)\bin\jar.exe"
jarflags = cf
dirsep = ^\
installdir = $(PROGRAMFILES)\ohNet
installlibdir = $(installdir)\lib
installincludedir = $(installdir)\include
mkdir = Scripts\mkdir.bat
rmdir = Scripts\rmdir.bat
uset4 = no

default : all

include T4Windows.mak
# Actual building of code is shared between platforms
include Common.mak

!if "$(uset4)"=="yes"
!if exist (Generated\GenerateSourceFiles.mak)
!include Generated\GenerateSourceFiles.mak
!else
!message Note: Generated\GenerateSourceFiles.mak does not yet exist. Try "make generate-makefiles".
!endif
!endif

!if exist (Generated\Proxies.mak)
!include Generated\Proxies.mak
!else
!message Note: Generated\Proxies.mak does not yet exist. Try "make generate-makefiles".
!endif

!if exist (Generated\Devices.mak)
!include Generated\Devices.mak
!else
!message Note: Generated\Devices.mak does not yet exist. Try "make generate-makefiles".
!endif

include UserTargets.mak

# Following macros must be provided by each file which wraps Common.mak

make_obj_dir:
	if not exist $(objdirbare) mkdir $(objdirbare)

copy_build_includes:
	if not exist $(inc_build) mkdir $(inc_build)
	if not exist $(inc_build)\OpenHome mkdir $(inc_build)\OpenHome
	if not exist $(inc_build)\OpenHome\Private mkdir $(inc_build)\OpenHome\Private
	if not exist $(inc_build)\OpenHome\Net mkdir $(inc_build)\OpenHome\Net
	if not exist $(inc_build)\OpenHome\Net\Private mkdir $(inc_build)\OpenHome\Net\Private
	if not exist $(inc_build)\OpenHome\Net\Core mkdir $(inc_build)\OpenHome\Net\Core
	if not exist $(inc_build)\OpenHome\Net\C mkdir $(inc_build)\OpenHome\Net\C
	if not exist $(inc_build)\OpenHome\Net\Cpp mkdir $(inc_build)\OpenHome\Net\Cpp
	if not exist $(inc_build)\OpenHome\Net\Private\Js mkdir $(inc_build)\OpenHome\Net\Private\Js
	if not exist $(inc_build)\OpenHome\Net\Private\Js\Tests mkdir $(inc_build)\OpenHome\Net\Private\Js\Tests
	if not exist $(inc_build)\OpenHome\Net\Private\Js\Tests\extern mkdir $(inc_build)\OpenHome\Net\Private\Js\Tests\extern
	if not exist $(inc_build)\OpenHome\Net\Private\Js\Tests\proxy mkdir $(inc_build)\OpenHome\Net\Private\Js\Tests\proxy
	copy OpenHome\*.h $(inc_build)\OpenHome\Private > nul
	copy OpenHome\Buffer.inl $(inc_build)\OpenHome > nul
    move $(inc_build)\OpenHome\Private\Buffer.h $(inc_build)\OpenHome > nul
    move $(inc_build)\OpenHome\Private\Exception.h $(inc_build)\OpenHome > nul
    move $(inc_build)\OpenHome\Private\Functor*.h $(inc_build)\OpenHome > nul
    move $(inc_build)\OpenHome\Private\MimeTypes.h $(inc_build)\OpenHome > nul
    move $(inc_build)\OpenHome\Private\OhNetDefines.h $(inc_build)\OpenHome > nul
    move $(inc_build)\OpenHome\Private\OsTypes.h $(inc_build)\OpenHome > nul
    move $(inc_build)\OpenHome\Private\OhNetTypes.h $(inc_build)\OpenHome > nul
	copy OpenHome\TestFramework\*.h $(inc_build)\OpenHome\Private > nul
	copy OpenHome\Net\*.h $(inc_build)\OpenHome\Net\Private > nul
    move $(inc_build)\OpenHome\Net\Private\FunctorAsync.h $(inc_build)\OpenHome\Net\Core > nul
    copy $(inc_build)\OpenHome\Net\Core\FunctorAsync.h $(inc_build)\OpenHome\Net\Cpp > nul
    move $(inc_build)\OpenHome\Net\Private\OhNet.h $(inc_build)\OpenHome\Net\Core > nul
    copy $(inc_build)\OpenHome\Net\Core\OhNet.h $(inc_build)\OpenHome\Net\Cpp > nul
	copy OpenHome\Net\ControlPoint\AsyncPrivate.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\ControlPoint\CpStack.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\ControlPoint\CpDevice.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\ControlPoint\CpDeviceDv.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\ControlPoint\CpDeviceUpnp.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\ControlPoint\CpProxy.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\ControlPoint\CpProxy.h $(inc_build)\OpenHome\Net\Cpp > nul
	copy OpenHome\Net\ControlPoint\CpTopology.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\ControlPoint\FunctorCpDevice.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\ControlPoint\Cpi*.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\ControlPoint\FunctorCpiDevice.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\ControlPoint\Dv\CpiDeviceDv.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\ControlPoint\Proxies\*.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\ControlPoint\Topology\*.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\ControlPoint\Upnp\*.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\Device\DvStack.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\Device\DvDevice.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\Device\DvInvocationResponse.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\Device\DvProvider.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\Device\DvProvider.h $(inc_build)\OpenHome\Net\Cpp > nul
	copy OpenHome\Net\Device\DvResourceWriter.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\Device\DvResourceWriter.h $(inc_build)\OpenHome\Net\Cpp > nul
	copy OpenHome\Net\Device\DvServerUpnp.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\Device\DvServerUpnp.h $(inc_build)\OpenHome\Net\Cpp > nul
	copy OpenHome\Net\Device\DviDevice.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\Device\DviServer.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\Device\DviService.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\Device\DviStack.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\Device\DviSubscription.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\Device\FunctorDviInvocation.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\Device\Bonjour\*.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\Device\Bonjour\mDNSCore\*.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\Device\Providers\*.h $(inc_build)\OpenHome\Net\Core > nul
	copy OpenHome\Net\Device\Upnp\*.h $(inc_build)\OpenHome\Net\Private > nul
	copy OpenHome\Net\Bindings\C\*.h $(inc_build)\OpenHome\Net\C > nul
	copy OpenHome\Net\Bindings\C\ControlPoint\*.h $(inc_build)\OpenHome\Net\C > nul
	copy OpenHome\Net\Bindings\C\ControlPoint\Proxies\*.h $(inc_build)\OpenHome\Net\C > nul
	copy OpenHome\Net\Bindings\C\Device\*.h $(inc_build)\OpenHome\Net\C > nul
	copy OpenHome\Net\Bindings\C\Device\Providers\*.h $(inc_build)\OpenHome\Net\C > nul
	copy OpenHome\Net\Bindings\Cpp\ControlPoint\*.h $(inc_build)\OpenHome\Net\Cpp > nul
	copy OpenHome\Net\Bindings\Cpp\ControlPoint\Proxies\*.h $(inc_build)\OpenHome\Net\Cpp > nul
	copy OpenHome\Net\Bindings\Cpp\Device\*.h $(inc_build)\OpenHome\Net\Cpp > nul
	copy OpenHome\Net\Bindings\Cpp\Device\Providers\*.h $(inc_build)\OpenHome\Net\Cpp > nul
    xcopy OpenHome\Net\Bindings\Js\ControlPoint\Tests\*.*/s $(inc_build)\OpenHome\Net\Private\Js\Tests /y > nul
    copy OpenHome\Net\Bindings\Js\ControlPoint\*.js $(inc_build)\OpenHome\Net\Private\Js\Tests\extern > nul
    copy OpenHome\Net\Bindings\Js\ControlPoint\Proxies\CpOpenhomeOrgTestBasic1.js $(inc_build)\OpenHome\Net\Private\Js\Tests\proxy > nul
	copy Os\*.h $(inc_build)\OpenHome > nul
	copy Os\*.inl $(inc_build)\OpenHome > nul

copy_build_includes_old:
	if not exist $(inc_build) mkdir $(inc_build)
	if not exist $(inc_build)\C mkdir $(inc_build)\C
	if not exist $(inc_build)\Cpp mkdir $(inc_build)\Cpp
	if not exist $(inc_build)\Cpp\Core mkdir $(inc_build)\Cpp\Core
	if not exist $(inc_build)\Cpp\Std mkdir $(inc_build)\Cpp\Std
    if not exist $(inc_build)\Js mkdir $(inc_build)\Js
    if not exist $(inc_build)\Js\Tests mkdir $(inc_build)\Js\Tests
    if not exist $(inc_build)\Js\Tests\css mkdir $(inc_build)\Js\Tests\css
    if not exist $(inc_build)\Js\Tests\Scripts mkdir $(inc_build)\Js\Tests\Scripts
    if not exist $(inc_build)\Js\Tests\extern mkdir $(inc_build)\Js\Tests\extern
    if not exist $(inc_build)\Js\Tests\proxy mkdir $(inc_build)\Js\Tests\proxy
    if not exist $(inc_build)\Js\Tests\test mkdir $(inc_build)\Js\Tests\test
    if not exist $(inc_build)\Js\Tests\test\assets mkdir $(inc_build)\Js\Tests\test\assets
    if not exist $(inc_build)\Js\Tests\test\assets\skins mkdir $(inc_build)\Js\Tests\test\assets\skins
    if not exist $(inc_build)\Js\Tests\test\assets\skins\sam mkdir $(inc_build)\Js\Tests\test\assets\skins\sam
	copy Api\*.h $(inc_build) > nul
	copy Api\C\*.h $(inc_build)\C > nul
	copy Api\Cpp\*.h $(inc_build)\Cpp > nul
	copy Api\Cpp\*.inl $(inc_build)\Cpp > nul
	copy Api\Cpp\Core\*.h $(inc_build)\Cpp\Core > nul
	copy Api\Cpp\Std\*.h $(inc_build)\Cpp\Std > nul
	copy *.h $(inc_build) > nul
	copy Bonjour\*.h $(inc_build) > nul
	copy Bonjour\mDNSCore\*.h $(inc_build) > nul
	copy ControlPoint\*.h $(inc_build) > nul
	copy ControlPoint\Services\Cpp\Core\*.h $(inc_build)\Cpp\Core > nul
	copy ControlPoint\Services\Cpp\Std\*.h $(inc_build)\Cpp\Std > nul
	copy ControlPoint\Services\C\*.h $(inc_build)\C > nul
	copy ControlPoint\Dv\*.h $(inc_build) > nul
	copy ControlPoint\Upnp\*.h $(inc_build) > nul
	copy Device\*.h $(inc_build) > nul
	copy Device\Services\Cpp\Core\*.h $(inc_build)\Cpp\Core > nul
	copy Device\Services\Cpp\Std\*.h $(inc_build)\Cpp\Std > nul
	copy Device\Services\C\*.h $(inc_build)\C > nul
	copy Device\Upnp\*.h $(inc_build) > nul
	copy Network\*.h $(inc_build) > nul
	copy Service\*.h $(inc_build) > nul
	copy Ssdp\*.h $(inc_build) > nul
	copy Os\*.h $(inc_build) > nul
	copy Os\*.inl $(inc_build) > nul
	copy Public\C\*.h $(inc_build)\C > nul
	copy Public\Cpp\Std\*.h $(inc_build)\Cpp\Std > nul
	copy Thread\Thread.h $(inc_build) > nul
	copy Utils\*.h $(inc_build) > nul
	copy TestFramework\*.h $(inc_build) > nul
    copy Public\Js\OhNet.Web.UI.Tests\*.html $(inc_build)\Js\Tests > nul
    copy Public\Js\OhNet.Web.UI.Tests\favicon.ico $(inc_build)\Js\Tests > nul
    copy Public\Js\OhNet.Web.UI.Tests\css\*.css $(inc_build)\Js\Tests\css > nul
    copy Public\Js\OhNet.Web.UI.Tests\Scripts\*.js $(inc_build)\Js\Tests\Scripts > nul
    copy Public\Js\OhNet.Web.UI.Tests\test\assets\skins\sam\*.css $(inc_build)\Js\Tests\test\assets\skins\sam > nul
    copy Public\Js\WebUIsdk\*.js $(inc_build)\Js\Tests\extern > nul
    copy ControlPoint\Services\Js\CpOpenhomeOrgTestBasic1.js $(inc_build)\Js\Tests\proxy > nul
    
install :
	if not exist "$(installdir)" mkdir "$(installdir)"
	if not exist "$(installlibdir)" mkdir "$(installlibdir)"
	if not exist "$(installincludedir)" mkdir "$(installincludedir)"
	copy "$(objdir)*" "$(installlibdir)" > nul
	xcopy "$(inc_build)" "$(installincludedir)" /Y /S /I > nul

uninstall :
	if not exist "$(installdir)" echo Nothing to uninstall && exit /b 1
	if exist "$(installlibdir)" del /q "$(installlibdir)\*" > nul
	if exist "$(installlibdir)" rmdir "$(installlibdir)"
	if exist "$(installincludedir)" rmdir /s /q "$(installincludedir)"
	rmdir "$(installdir)"

bundle: tt
	if not exist "$(bundle_build)" mkdir "$(bundle_build)"
	if "$(targetplatform)"=="" echo "Usage: make bundle targetplatform=Windows-x86" && exit /b 1
	python bundle_binaries.py Windows $(targetplatform)

bundle-dev: tt
	if not exist "$(bundle_build)" mkdir "$(bundle_build)"
	if "$(targetplatform)"=="" echo "Usage: make bundle-dev targetplatform=Windows-x86" && exit /b 1
	python bundle_binaries.py --dev Windows $(targetplatform)
