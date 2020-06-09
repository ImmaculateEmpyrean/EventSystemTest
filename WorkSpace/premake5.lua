workspace "EventSystemTest"
    architecture "x86_64"
    startproject "EventTester"

	configurations
	{
		"Debug",
        "StaticLibRelease",
        "DynamicLibRelease"
	}
	
	flags
	{
		"MultiProcessorCompile"
    }
	
	outputdir = "%{cfg.buildcfg}-%{cfg.platform}-%{cfg.system}-%{cfg.architecture}"
    --outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}" -- This is a string object ..

--Start Defining The Main Project

include "EventSystem/Workspace/EventSystem"

--BuildHelper Project

project "EventTester"
	location "EventTester"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"EventSystem/Workspace/EventSystem/src"
	}

	links
	{
		"EventSystem"
	}

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"
		defines
		{
			"ER_DEBUG_DEVELOP"
		}

	filter "configurations:StaticLibRelease"
		runtime "Release"
		optimize "on"

	filter "configurations:DynamicLibRelease"
		runtime "Release"
		optimize "on"

	filter ""

	defines
	{
		"_CRT_SECURE_NO_WARNINGS",
		"USINGErmineEventSystem"
	}
