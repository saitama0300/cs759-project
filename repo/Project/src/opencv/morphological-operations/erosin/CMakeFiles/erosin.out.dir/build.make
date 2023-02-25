# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.24

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/homebrew/Cellar/cmake/3.24.2/bin/cmake

# The command to remove a file.
RM = /opt/homebrew/Cellar/cmake/3.24.2/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/tanmay/Desktop/Acads/cs759-hpc/repo759/Project/src/opencv/morphological-operations/erosin

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/tanmay/Desktop/Acads/cs759-hpc/repo759/Project/src/opencv/morphological-operations/erosin

# Include any dependencies generated for this target.
include CMakeFiles/erosin.out.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/erosin.out.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/erosin.out.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/erosin.out.dir/flags.make

CMakeFiles/erosin.out.dir/erosin.cpp.o: CMakeFiles/erosin.out.dir/flags.make
CMakeFiles/erosin.out.dir/erosin.cpp.o: erosin.cpp
CMakeFiles/erosin.out.dir/erosin.cpp.o: CMakeFiles/erosin.out.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/tanmay/Desktop/Acads/cs759-hpc/repo759/Project/src/opencv/morphological-operations/erosin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/erosin.out.dir/erosin.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/erosin.out.dir/erosin.cpp.o -MF CMakeFiles/erosin.out.dir/erosin.cpp.o.d -o CMakeFiles/erosin.out.dir/erosin.cpp.o -c /Users/tanmay/Desktop/Acads/cs759-hpc/repo759/Project/src/opencv/morphological-operations/erosin/erosin.cpp

CMakeFiles/erosin.out.dir/erosin.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/erosin.out.dir/erosin.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/tanmay/Desktop/Acads/cs759-hpc/repo759/Project/src/opencv/morphological-operations/erosin/erosin.cpp > CMakeFiles/erosin.out.dir/erosin.cpp.i

CMakeFiles/erosin.out.dir/erosin.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/erosin.out.dir/erosin.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/tanmay/Desktop/Acads/cs759-hpc/repo759/Project/src/opencv/morphological-operations/erosin/erosin.cpp -o CMakeFiles/erosin.out.dir/erosin.cpp.s

# Object files for target erosin.out
erosin_out_OBJECTS = \
"CMakeFiles/erosin.out.dir/erosin.cpp.o"

# External object files for target erosin.out
erosin_out_EXTERNAL_OBJECTS =

erosin.out: CMakeFiles/erosin.out.dir/erosin.cpp.o
erosin.out: CMakeFiles/erosin.out.dir/build.make
erosin.out: /opt/homebrew/lib/libopencv_gapi.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_stitching.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_alphamat.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_aruco.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_barcode.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_bgsegm.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_bioinspired.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_ccalib.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_dnn_objdetect.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_dnn_superres.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_dpm.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_face.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_freetype.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_fuzzy.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_hfs.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_img_hash.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_intensity_transform.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_line_descriptor.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_mcc.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_quality.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_rapid.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_reg.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_rgbd.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_saliency.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_sfm.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_stereo.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_structured_light.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_superres.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_surface_matching.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_tracking.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_videostab.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_viz.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_wechat_qrcode.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_xfeatures2d.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_xobjdetect.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_xphoto.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_shape.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_highgui.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_datasets.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_plot.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_text.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_ml.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_phase_unwrapping.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_optflow.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_ximgproc.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_video.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_videoio.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_imgcodecs.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_objdetect.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_calib3d.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_dnn.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_features2d.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_flann.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_photo.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_imgproc.4.6.0.dylib
erosin.out: /opt/homebrew/lib/libopencv_core.4.6.0.dylib
erosin.out: CMakeFiles/erosin.out.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/tanmay/Desktop/Acads/cs759-hpc/repo759/Project/src/opencv/morphological-operations/erosin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable erosin.out"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/erosin.out.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/erosin.out.dir/build: erosin.out
.PHONY : CMakeFiles/erosin.out.dir/build

CMakeFiles/erosin.out.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/erosin.out.dir/cmake_clean.cmake
.PHONY : CMakeFiles/erosin.out.dir/clean

CMakeFiles/erosin.out.dir/depend:
	cd /Users/tanmay/Desktop/Acads/cs759-hpc/repo759/Project/src/opencv/morphological-operations/erosin && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/tanmay/Desktop/Acads/cs759-hpc/repo759/Project/src/opencv/morphological-operations/erosin /Users/tanmay/Desktop/Acads/cs759-hpc/repo759/Project/src/opencv/morphological-operations/erosin /Users/tanmay/Desktop/Acads/cs759-hpc/repo759/Project/src/opencv/morphological-operations/erosin /Users/tanmay/Desktop/Acads/cs759-hpc/repo759/Project/src/opencv/morphological-operations/erosin /Users/tanmay/Desktop/Acads/cs759-hpc/repo759/Project/src/opencv/morphological-operations/erosin/CMakeFiles/erosin.out.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/erosin.out.dir/depend

