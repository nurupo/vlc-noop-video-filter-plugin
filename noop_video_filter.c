/*****************************************************************************
 * noop_video_filter.c : A filter that does nothing
 *****************************************************************************
 * Copyright (C) 2020 Maxim Biro
 *
 * Authors: Maxim Biro <nurupo.contributions@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
 *****************************************************************************/

#include <vlc_common.h>
#include <vlc_filter.h>
#include <vlc_plugin.h>

#include <vlc_es.h>

static int Create(vlc_object_t *);
static void Destroy(vlc_object_t *);

vlc_module_begin()
    set_description("Noop video filter")
    set_shortname("Noop video filter")
    set_capability("video filter", 0)
    set_category(CAT_VIDEO)
    set_subcategory(SUBCAT_VIDEO_VFILTER)
    set_callbacks(Create, Destroy)
vlc_module_end()

static picture_t *filter(filter_t *p_filter, picture_t *p_pic_in)
{
    // don't alter picture
    return p_pic_in;
}

static int Create(vlc_object_t *p_this)
{
    filter_t *p_filter = (filter_t *)p_this;
    p_filter->pf_video_filter = filter;

    video_format_Print(p_this, "noop_video FORMAT IN", &p_filter->fmt_in.video);
    video_format_Print(p_this, "noop_video FORMAT OUT", &p_filter->fmt_out.video);

    switch(p_filter->fmt_in.video.i_chroma)
    {
        case VLC_CODEC_D3D11_OPAQUE:
        case VLC_CODEC_D3D11_OPAQUE_10B:
            msg_Err( p_filter, "Unsupported input chroma (%4.4s)",
                     (char*)&(p_filter->fmt_in.video.i_chroma) );
            return VLC_EGENERIC;
    }

    return VLC_SUCCESS;
}

static void Destroy(vlc_object_t *p_this)
{
}
