# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GST_PLUGINS_GOOD) += gst-plugins-good

#
# Paths and names
#
GST_PLUGINS_GOOD_VERSION	:= 0.10.31
GST_PLUGINS_GOOD_MD5		:= 24f98a294a2b521e1b29412bdadae2e6
GST_PLUGINS_GOOD		:= gst-plugins-good-$(GST_PLUGINS_GOOD_VERSION)
GST_PLUGINS_GOOD_SUFFIX		:= tar.bz2
GST_PLUGINS_GOOD_URL		:= http://gstreamer.freedesktop.org/src/gst-plugins-good/$(GST_PLUGINS_GOOD).$(GST_PLUGINS_GOOD_SUFFIX)
GST_PLUGINS_GOOD_SOURCE		:= $(SRCDIR)/$(GST_PLUGINS_GOOD).$(GST_PLUGINS_GOOD_SUFFIX)
GST_PLUGINS_GOOD_DIR		:= $(BUILDDIR)/$(GST_PLUGINS_GOOD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_VIDEOFILTER)	+= videofilter
GST_PLUGINS_GOOD_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD_ALPHA)	+= alpha
GST_PLUGINS_GOOD_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD_ALPHA)	+= alpha alphacolor
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_APETAG)	+= apetag
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_AUDIOFX)	+= audiofx
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_AUDIOPARSERS)+= audioparsers
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_AUPARSE)	+= auparse
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_AUTODETECT)	+= autodetect
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_AVI)		+= avi
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_CUTTER)	+= cutter
GST_PLUGINS_GOOD_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD_DEBUGUTILS)	+= debugutils
GST_PLUGINS_GOOD_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD_DEBUGUTILS)	+= debug navigationtest
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_DEINTERLACE)	+= deinterlace
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_EFFECTV)	+= effectv
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_EQUALIZER)	+= equalizer
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_FLV)		+= flv
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_ID3DEMUX)	+= id3demux
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_ICYDEMUX)	+= icydemux
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_INTERLEAVE)	+= interleave
GST_PLUGINS_GOOD_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD_FLX)	+= flx
GST_PLUGINS_GOOD_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD_FLX)	+= flxdec
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_GOOM)	+= goom
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_GOOM2K1)	+= goom2k1
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_IMAGEFREEZE)	+= imagefreeze
GST_PLUGINS_GOOD_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD_LAW)	+= law
GST_PLUGINS_GOOD_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD_LAW)	+= alaw mulaw
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_LEVEL)	+= level
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_MATROSKA)	+= matroska
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_MONOSCOPE)	+= monoscope
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_MULTIFILE)	+= multifile
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_MULTIPART)	+= multipart
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_QTDEMUX)	+= isomp4
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_REPLAYGAIN)	+= replaygain
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_RTP)		+= rtp
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_RTPMANAGER)	+= rtpmanager
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_RTSP)	+= rtsp
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_SHAPEWIPE)	+= shapewipe
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_SMPTE)	+= smpte
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_SPECTRUM)	+= spectrum
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_UDP)		+= udp
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_VIDEOBOX)	+= videobox
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_VIDEOCROP)	+= videocrop
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_VIDEOMIXER)	+= videomixer
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_WAVENC)	+= wavenc
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_WAVPARSE)	+= wavparse
GST_PLUGINS_GOOD_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD_Y4M)	+= y4m
GST_PLUGINS_GOOD_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD_Y4M)	+= y4menc
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_DIRECTSOUND)	+= directsound
GST_PLUGINS_GOOD_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD_OSS)	+= oss
GST_PLUGINS_GOOD_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD_OSS)	+= ossaudio
GST_PLUGINS_GOOD_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD_OSS4)	+= oss4
GST_PLUGINS_GOOD_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD_OSS4)	+= oss4audio
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_SUNAUDIO)	+= sunaudio
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_OSX_AUDIO)	+= osx_audio
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_OSX_VIDEO)	+= osx_video
GST_PLUGINS_GOOD_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD_GST_V4L2)	+= gst_v4l2
GST_PLUGINS_GOOD_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD_GST_V4L2)	+= video4linux2
GST_PLUGINS_GOOD_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD_X)		+= x
GST_PLUGINS_GOOD_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD_X)		+= ximagesrc
GST_PLUGINS_GOOD_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD_XSHM)	+= xshm
GST_PLUGINS_GOOD_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD_XVIDEO)	+= xvideo
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_AALIB)	+= aalib
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_ANNODEX)	+= annodex
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_CAIRO)	+= cairo
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_ESD)		+= esd
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_FLAC)	+= flac
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_GCONF)	+= gconf
GST_PLUGINS_GOOD_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD_GDK_PIXBUF)	+= gdk_pixbuf
GST_PLUGINS_GOOD_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD_GDK_PIXBUF)	+= gdkpixbuf
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_HAL)		+= hal
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_JPEG)	+= jpeg
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_JACK)	+= jack
GST_PLUGINS_GOOD_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD_LIBCACA)	+= libcaca
GST_PLUGINS_GOOD_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD_LIBCACA)	+= cacasink
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_LIBDV)	+= libdv
GST_PLUGINS_GOOD_ENABLEC-$(PTXCONF_GST_PLUGINS_GOOD_LIBPNG)	+= libpng
GST_PLUGINS_GOOD_ENABLEP-$(PTXCONF_GST_PLUGINS_GOOD_LIBPNG)	+= png
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_PULSE)	+= pulse
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_DV1394)	+= dv1394
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_SHOUT2)	+= shout2
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_SOUP)	+= soup
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_SPEEX)	+= speex
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_TAGLIB)	+= taglib
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_WAVPACK)	+= wavpack

GST_PLUGINS_GOOD_ENABLEC-y	+= $(GST_PLUGINS_GOOD_ENABLE-y)
GST_PLUGINS_GOOD_ENABLEC-	+= $(GST_PLUGINS_GOOD_ENABLE-)
GST_PLUGINS_GOOD_ENABLEP-y	+= $(GST_PLUGINS_GOOD_ENABLE-y)

#
# autoconf
#
GST_PLUGINS_GOOD_CONF_TOOL	:= autoconf
GST_PLUGINS_GOOD_CONF_OPT	= \
	$(CROSS_AUTOCONF_USR) \
	$(GSTREAMER_GENERIC_CONF_OPT) \
	--enable-external \
	--enable-experimental \
	--disable-schemas-install \
	--disable-gconftool \
	--disable-esdtest \
	--disable-aalibtest \
	--$(call ptx/endis,PTXCONF_GST_PLUGINS_GOOD_ZLIB)-zlib \
	--$(call ptx/endis,PTXCONF_GST_PLUGINS_GOOD_BZ2)-bz2 \
	--$(call ptx/wwo,PTXCONF_GST_PLUGINS_GOOD_GST_V4L2)-gudev \
	--$(call ptx/wwo,PTXCONF_GST_PLUGINS_GOOD_GST_V4L2_LIBV4L2)-libv4l2

#
# the --with-plugins sadly only applies to depencyless plugings
# and when no plugins are sellected it builds them all. So
# --with-plugins is useless, so we generate a --enable-*
# and --disable-* below
#
ifneq ($(call remove_quotes,$(GST_PLUGINS_GOOD_ENABLEC-y)),)
GST_PLUGINS_GOOD_CONF_OPT +=  --enable-$(subst $(space),$(space)--enable-,$(strip $(GST_PLUGINS_GOOD_ENABLEC-y)))
endif

ifneq ($(call remove_quotes,$(GST_PLUGINS_GOOD_ENABLEC-)),)
GST_PLUGINS_GOOD_CONF_OPT +=  --disable-$(subst $(space),$(space)--disable-,$(strip $(GST_PLUGINS_GOOD_ENABLEC-)))
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-good.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-plugins-good)
	@$(call install_fixup, gst-plugins-good,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-good,SECTION,base)
	@$(call install_fixup, gst-plugins-good,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gst-plugins-good,DESCRIPTION,missing)

	@for plugin in $(GST_PLUGINS_GOOD_ENABLEP-y); do \
		$(call install_copy, gst-plugins-good, 0, 0, 0644, -, \
			/usr/lib/gstreamer-0.10/libgst$${plugin}.so); \
	done

	@$(call install_finish, gst-plugins-good)

	@$(call touch)

# vim: syntax=make
