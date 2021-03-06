# -*-makefile-*-
#
# Copyright (C) 2014 by Christoph Fritz <chf.fritz@googlemail.com>
# Copyright (C) 2013 by Jan Weitzel <J.Weitzel@phytec.de>
# loosely based on work by Roman Dosek <formatsh@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENCV) += opencv

#
# Paths and names
#

OPENCV_VERSION	:= 4.2.0
OPENCV_MD5	:= b02b54115f1f99cb9e885d1e5988ff70
OPENCV		:= opencv-$(OPENCV_VERSION)
OPENCV_SUFFIX	:= zip
OPENCV_URL	:= \
	$(call ptx/mirror, SF, opencvlibrary/opencv-unix/$(OPENCV_VERSION)/$(OPENCV).$(OPENCV_SUFFIX)) \
	https://github.com/opencv/opencv/archive/$(OPENCV_VERSION).$(OPENCV_SUFFIX)
OPENCV_SOURCE	:= $(SRCDIR)/$(OPENCV).$(OPENCV_SUFFIX)
OPENCV_DIR	:= $(BUILDDIR)/$(OPENCV)
OPENCV_LICENSE	:= BSD
OPENCV_BUILD_DIR := $(OPENCV_DIR)-build
# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPENCV_CONF_TOOL	:= cmake

OPENCV_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DANT_EXECUTABLE:FILEPATH= \
	-DBUILD_CUDA_STUBS:BOOL=OFF \
	-DBUILD_DOCS:BOOL=OFF \
	-DBUILD_EXAMPLES:BOOL=$(call ptx/onoff, PTXCONF_OPENCV_EXAMPLES) \
	-DBUILD_ITT=ON \
	-DBUILD_JASPER=OFF \
	-DBUILD_JAVA=OFF \
	-DBUILD_JPEG=OFF \
	-DBUILD_LIST= \
	-DBUILD_OPENEXR=OFF \
	-DBUILD_PACKAGE:BOOL=OFF \
	-DBUILD_PERF_TESTS=OFF \
	-DBUILD_PNG=OFF \
	-DBUILD_PROTOBUF=ON \
	-DBUILD_SHARED_LIBS:BOOL=ON \
	-DBUILD_TBB=OFF \
	-DBUILD_TESTS=OFF \
	-DBUILD_TIFF=OFF \
	-DBUILD_USE_SYMLINKS=OFF \
	-DBUILD_WEBP=OFF \
	-DBUILD_WITH_DEBUG_INFO=OFF \
	-DBUILD_WITH_DYNAMIC_IPP=OFF \
	-DBUILD_ZLIB=OFF \
	-DBUILD_opencv_apps:BOOL=OFF \
	-DBUILD_opencv_calib3d:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_CALIB3D) \
	-DBUILD_opencv_core:BOOL=ON \
	-DBUILD_opencv_dnn=$(call ptx/onoff,PTXCONF_OPENCV_DNN) \
	-DBUILD_opencv_features2d:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_FEATURES2D) \
	-DBUILD_opencv_flann:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_FLANN) \
	-DBUILD_opencv_highgui:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_HIGHGUI)  \
	-DBUILD_opencv_imgcodecs=$(call ptx/onoff,PTXCONF_OPENCV_IMGCODECS) \
	-DBUILD_opencv_imgproc:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_IMGPROC) \
	-DBUILD_opencv_java_bindings_generator=ON \
	-DBUILD_opencv_js=OFF \
	-DBUILD_opencv_ml:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_ML) \
	-DBUILD_opencv_objdetect:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_OBJDETECT) \
	-DBUILD_opencv_photo:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_PHOTO) \
	-DBUILD_opencv_python_bindings_generator=ON \
	-DBUILD_opencv_python_tests=ON \
	-DBUILD_opencv_stitching:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_STITCHING) \
	-DBUILD_opencv_ts:BOOL=OFF \
	-DBUILD_opencv_videoio:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_VIDEOIO) \
	-DBUILD_opencv_video:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_VIDEO) \
	-DBUILD_opencv_world:BOOL=OFF \
	-DCAROTENE_NS=carotene_o4t \
	-DCMAKE_SKIP_RPATH:BOOL=ON \
	-DCPU_BASELINE=DETECT \
	-DCPU_DISPATCH= \
	-DCV_DISABLE_OPTIMIZATION=OFF \
	-DCV_ENABLE_INTRINSICS=ON \
	-DCV_TRACE=ON \
	-DENABLE_BUILD_HARDENING=OFF \
	-DENABLE_CCACHE=OFF \
	-DENABLE_CONFIG_VERIFICATION=OFF \
	-DENABLE_COVERAGE=OFF \
	-DENABLE_FAST_MATH=ON \
	-DENABLE_GNU_STL_DEBUG=OFF \
	-DENABLE_IMPL_COLLECTION=OFF \
	-DENABLE_INSTRUMENTATION=OFF \
	-DENABLE_LTO=OFF \
	-DENABLE_NEON:BOOL=$(call ptx/onoff,PTXCONF_ARCH_ARM_NEON) \
	-DENABLE_NOISY_WARNINGS=OFF \
	-DENABLE_OMIT_FRAME_POINTER=ON \
	-DENABLE_PIC=ON \
	-DENABLE_PROFILING=OFF \
	-DENABLE_SOLUTION_FOLDERS=OFF \
	-DENABLE_VFPV3:BOOL=OFF \
	-DGENERATE_ABI_DESCRIPTOR=OFF \
	-DINSTALL_CREATE_DISTRIB:BOOL=OFF \
	-DINSTALL_C_EXAMPLES:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_EXAMPLES) \
	-DINSTALL_PYTHON_EXAMPLES:BOOL=OFF \
	-DINSTALL_TESTS=OFF \
	-DINSTALL_TO_MANGLED_PATHS:BOOL=OFF \
	-DMKL_WITH_OPENMP=OFF \
	-DMKL_WITH_TBB=OFF \
	-DOPENCV_DOWNLOAD_PATH=$(OPENCV_DIR)/.cache \
	-DOPENCV_DUMP_HOOKS_FLOW=OFF \
	-DOPENCV_ENABLE_MEMALIGN=ON \
	-DOPENCV_ENABLE_MEMORY_SANITIZER=OFF \
	-DOPENCV_ENABLE_NONFREE=OFF \
	-DOPENCV_EXTRA_MODULES_PATH:PATH= \
	-DOPENCV_FORCE_3RDPARTY_BUILD=OFF \
	-DOPENCV_GENERATE_PKGCONFIG=ON \
	-DOPENCV_GENERATE_SETUPVARS=ON \
	-DOPENCV_PYTHON3_VERSION=OFF \
	-DOPENCV_WARNINGS_ARE_ERRORS:BOOL=OFF \
	-DPROTOBUF_UPDATE_FILES=OFF \
	-DWITH_1394:BOOL=OFF \
	-DWITH_ADE=OFF \
	-DWITH_ARAVIS=OFF \
	-DWITH_CAROTENE=ON \
	-DWITH_CLP=OFF \
	-DWITH_CUBLAS:BOOL=OFF \
	-DWITH_CUDA:BOOL=OFF \
	-DWITH_CUFFT:BOOL=OFF \
	-DWITH_EIGEN:BOOL=OFF \
	-DWITH_FFMPEG:BOOL=OFF \
	-DWITH_GDAL:BOOL=OFF \
	-DWITH_GDCM=OFF \
	-DWITH_GIGEAPI:BOOL=OFF \
	-DWITH_GPHOTO2:BOOL=OFF \
	-DWITH_GSTREAMER:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_GSTREAMER) \
	-DWITH_GTK:BOOL=OFF \
	-DWITH_GTK_2_X=OFF \
	-DWITH_HALIDE=OFF \
	-DWITH_HPX=OFF \
	-DWITH_IMGCODEC_HDR=ON \
	-DWITH_IMGCODEC_PFM=ON \
	-DWITH_IMGCODEC_PXM=ON \
	-DWITH_IMGCODEC_SUNRASTER=ON \
	-DWITH_INF_ENGINE=OFF \
	-DWITH_IPP_A:BOOL=OFF \
	-DWITH_IPP=OFF \
	-DWITH_ITT=ON \
	-DWITH_JASPER:BOOL=OFF \
	-DWITH_JPEG:BOOL=ON \
	-DWITH_LAPACK=ON \
	-DWITH_LIBREALSENSE=OFF \
	-DWITH_LIBV4L:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_V4L_LIBV4L2) \
	-DWITH_MFX=OFF \
	-DWITH_NVCUVID:BOOL=OFF \
	-DWITH_OPENCL:BOOL=ON \
	-DWITH_OPENCLAMDBLAS:BOOL=OFF \
	-DWITH_OPENCLAMDFFT:BOOL=OFF \
	-DWITH_OPENCL_SVM:BOOL=OFF \
	-DWITH_OPENEXR:BOOL=OFF \
	-DWITH_OPENGL:BOOL=OFF \
	-DWITH_OPENMP:BOOL=OFF \
	-DWITH_OPENNI:BOOL=OFF \
	-DWITH_OPENNI2:BOOL=OFF \
	-DWITH_OPENVX=OFF \
	-DWITH_PNG:BOOL=ON \
	-DWITH_PROTOBUF=ON \
	-DWITH_PTHREADS_PF:BOOL=OFF \
	-DWITH_PVAPI:BOOL=OFF \
	-DWITH_QT:BOOL=$(call ptx/ifdef,PTXCONF_OPENCV_QT,5,OFF) \
	-DWITH_QUIRC=ON \
	-DWITH_TBB:BOOL=OFF \
	-DWITH_TIFF:BOOL=OFF \
	-DWITH_UNICAP:BOOL=OFF \
	-DWITH_V4L:BOOL=$(call ptx/onoff,PTXCONF_OPENCV_V4L) \
	-DWITH_VA=OFF \
	-DWITH_VA_INTEL=OFF \
	-DWITH_VULKAN=OFF \
	-DWITH_WEBP:BOOL=OFF \
	-DWITH_XIMEA:BOOL=OFF \
	-DWITH_XINE:BOOL=OFF \
	-DOPENCV_GENERATE_PKGCONFIG=ON \


$(STATEDIR)/opencv.install:
	@$(call targetinfo)
	@$(call world/install, OPENCV)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

OPENCV_LIBS-$(PTXCONF_OPENCV)			:= libopencv_core
OPENCV_LIBS-$(PTXCONF_OPENCV_CALIB3D)		+= libopencv_calib3d
OPENCV_LIBS-$(PTXCONF_OPENCV_DNN)		+= libopencv_dnn
OPENCV_LIBS-$(PTXCONF_OPENCV_FEATURES2D)	+= libopencv_features2d
OPENCV_LIBS-$(PTXCONF_OPENCV_FLANN)		+= libopencv_flann
OPENCV_LIBS-$(PTXCONF_OPENCV_HIGHGUI)		+= libopencv_highgui
OPENCV_LIBS-$(PTXCONF_OPENCV_IMGCODECS)		+= libopencv_imgcodecs
OPENCV_LIBS-$(PTXCONF_OPENCV_IMGPROC)		+= libopencv_imgproc
OPENCV_LIBS-$(PTXCONF_OPENCV_ML)		+= libopencv_ml
OPENCV_LIBS-$(PTXCONF_OPENCV_OBJDETECT)		+= libopencv_objdetect
OPENCV_LIBS-$(PTXCONF_OPENCV_PHOTO)		+= libopencv_photo
OPENCV_LIBS-$(PTXCONF_OPENCV_STITCHING)		+= libopencv_stitching
OPENCV_LIBS-$(PTXCONF_OPENCV_VIDEO)		+= libopencv_video
OPENCV_LIBS-$(PTXCONF_OPENCV_VIDEOIO)		+= libopencv_videoio

$(STATEDIR)/opencv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, opencv)
	@$(call install_fixup, opencv, PRIORITY, optional)
	@$(call install_fixup, opencv, SECTION, base)
	@$(call install_fixup, opencv, AUTHOR, "Christoph Fritz <chf.fritz@googlemail.com>")
	@$(call install_fixup, opencv, DESCRIPTION, missing)

	@$(foreach lib, $(OPENCV_LIBS-y), \
		$(call install_lib, opencv, 0, 0, 0644, $(lib));)
	@$(call install_tree, opencv, 0, 0, $(OPENCV_BUILD_DIR)/bin, /bin)
	@$(call install_finish, opencv)
	@$(call touch)

# vim: syntax=make
