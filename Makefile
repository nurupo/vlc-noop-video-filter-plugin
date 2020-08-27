LD = ld
CC = cc
OS = Linux
DESTDIR =
INSTALL = install
CFLAGS = -g0 -O3 -Wall -Wextra
LDFLAGS =
VLC_PLUGIN_CFLAGS := $(shell pkg-config --cflags vlc-plugin)
VLC_PLUGIN_LIBS := $(shell pkg-config --libs vlc-plugin)

plugindir := $(shell pkg-config vlc-plugin --variable=pluginsdir)

override CC += -std=gnu11
override CPPFLAGS += -DPIC -I. -Isrc
override CFLAGS += -fPIC

override CPPFLAGS += -DMODULE_STRING=\"noop_video_filter\"
override CFLAGS += $(VLC_PLUGIN_CFLAGS)
override LDFLAGS += $(VLC_PLUGIN_LIBS)

ifeq ($(OS),Linux)
  EXT := so
else ifeq ($(OS),Windows)
  EXT := dll
else ifeq ($(OS),macOS)
  EXT := dylib
else
  $(error Unknown OS specified, please set OS to either Linux, Windows or macOS)
endif

TARGETS = libnoop_video_filter_plugin.$(EXT)

all: libnoop_video_filter_plugin.$(EXT)

install: all
	mkdir -p -- $(DESTDIR)$(plugindir)/video_filter
	$(INSTALL) --mode 0755 libnoop_video_filter_plugin.$(EXT) $(DESTDIR)$(plugindir)/video_filter

install-strip:
	$(MAKE) install INSTALL="$(INSTALL) -s"

uninstall:
	rm -f $(DESTDIR)$(plugindir)/video_filter/libnoop_video_filter_plugin.$(EXT)

clean:
	rm -f -- libnoop_video_filter_plugin.$(EXT) noop_video_filter.o

mostlyclean: clean

SOURCES = noop_video_filter.c

$(SOURCES:%.c=%.o): %: noop_video_filter.c

libnoop_video_filter_plugin.$(EXT): $(SOURCES:%.c=%.o)
	$(CC) -shared -o $@ $^ $(LDFLAGS)

.PHONY: all install install-strip uninstall clean mostlyclean
