/* mnote-olympus-tag.h
 *
 * Copyright (c) 2002 Lutz Mueller <lutz@users.sourceforge.net>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details. 
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#ifndef __MNOTE_OLYMPUS_TAG_H__
#define __MNOTE_OLYMPUS_TAG_H__

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

enum _MnoteOlympusTag {

	/* Nikon v.2 */
	MNOTE_NIKON_TAG_FIRMWARE                = 0x0001,
	MNOTE_NIKON_TAG_ISO                     = 0x0002,
	MNOTE_NIKON_TAG_COLORMODE1              = 0x0003,
	MNOTE_NIKON_TAG_QUALITY                 = 0x0004,
	MNOTE_NIKON_TAG_WHITEBALANCE            = 0x0005,
	MNOTE_NIKON_TAG_SHARPENING              = 0x0006,
	MNOTE_NIKON_TAG_FOCUSMODE               = 0x0007,
	MNOTE_NIKON_TAG_FLASHSETTING            = 0x0008,
	MNOTE_NIKON_TAG_FLASHMODE               = 0x0009,
	MNOTE_NIKON_TAG_WHITEBALANCEFINE        = 0x000b,
	MNOTE_NIKON_TAG_WHITEBALANCERB          = 0x000c,
	MNOTE_NIKON_TAG_UNKNOWN_0X000D          = 0x000d,
	MNOTE_NIKON_TAG_EXPOSUREDIFF            = 0x000e,
	MNOTE_NIKON_TAG_ISOSELECTION            = 0x000f,
	MNOTE_NIKON_TAG_PREVIEWIMAGE            = 0x0011,
	MNOTE_NIKON_TAG_FLASHEXPCOMPENSATION    = 0x0012,
	MNOTE_NIKON_TAG_ISO2                    = 0x0013,
	MNOTE_NIKON_TAG_IMAGEBOUNDARY           = 0x0016,
	MNOTE_NIKON_TAG_UNKNOWN_0X0017          = 0x0017,
	MNOTE_NIKON_TAG_FLASHEXPOSUREBRACKETVAL = 0x0018,
	MNOTE_NIKON_TAG_EXPOSUREBRACKETVAL      = 0x0019,
	MNOTE_NIKON_TAG_IMAGEADJUSTMENT         = 0x0080,
	MNOTE_NIKON_TAG_TONECOMPENSATION        = 0x0081,
	MNOTE_NIKON_TAG_ADAPTER                 = 0x0082,
	MNOTE_NIKON_TAG_LENSTYPE                = 0x0083,
	MNOTE_NIKON_TAG_LENS                    = 0x0084,
	MNOTE_NIKON_TAG_MANUALFOCUSDISTANCE     = 0x0085,
	MNOTE_NIKON_TAG_DIGITALZOOM             = 0x0086,
	MNOTE_NIKON_TAG_FLASHUSED               = 0x0087,
	MNOTE_NIKON_TAG_AFFOCUSPOSITION         = 0x0088,
	MNOTE_NIKON_TAG_BRACKETING              = 0x0089,
	MNOTE_NIKON_TAG_UNKNOWN_0X008A          = 0x008a,
	MNOTE_NIKON_TAG_LENS_FSTOPS             = 0x008b,
	MNOTE_NIKON_TAG_CURVE                   = 0x008c,
	MNOTE_NIKON_TAG_COLORMODE               = 0x008d,
	MNOTE_NIKON_TAG_LIGHTTYPE               = 0x0090,
	MNOTE_NIKON_TAG_UNKNOWN_0X0091          = 0x0091,
	MNOTE_NIKON_TAG_HUE                     = 0x0092,
	MNOTE_NIKON_TAG_SATURATION              = 0x0094,
	MNOTE_NIKON_TAG_NOISEREDUCTION          = 0x0095,
	MNOTE_NIKON_TAG_UNKNOWN_0X0097          = 0x0097,
	MNOTE_NIKON_TAG_UNKNOWN_0X0098          = 0x0098,
	MNOTE_NIKON_TAG_SENSORPIXELSIZE         = 0x009a,
	MNOTE_NIKON_TAG_UNKNOWN_0X009B          = 0x009b,
	MNOTE_NIKON_TAG_SERIALNUMBER            = 0x00a0,
	MNOTE_NIKON_TAG_IMAGE_DATASIZE          = 0x00a2,
	MNOTE_NIKON_TAG_UNKNOWN_0X00A3          = 0x00a3,
	MNOTE_NIKON_TAG_TOTALPICTURES           = 0x00a7,
	MNOTE_NIKON_TAG_UNKNOWN_0X00A8          = 0x00a8,
	MNOTE_NIKON_TAG_OPTIMIZATION            = 0x00a9,
	MNOTE_NIKON_TAG_SATURATION2             = 0x00aa,
	MNOTE_NIKON_TAG_VARIPROGRAM             = 0x00ab,
	MNOTE_NIKON_TAG_CAPTUREEDITORDATA       = 0x0e01,
	MNOTE_NIKON_TAG_CAPTUREEDITORVER	= 0x0e09,
	MNOTE_NIKON_TAG_UNKNOWN_0X0E0E		= 0x0e0e,
	MNOTE_NIKON_TAG_UNKNOWN_0X0E10		= 0x0e10,

	/* Nikon v1: real values + our proprietary base to distinguish from v2 */
	MNOTE_NIKON1_TAG_BASE                   = 0x8000,
	MNOTE_NIKON1_TAG_UNKNOWN_0X0002         = 0x0002 + MNOTE_NIKON1_TAG_BASE,
	MNOTE_NIKON1_TAG_QUALITY                = 0x0003 + MNOTE_NIKON1_TAG_BASE,
	MNOTE_NIKON1_TAG_COLORMODE              = 0x0004 + MNOTE_NIKON1_TAG_BASE,
	MNOTE_NIKON1_TAG_IMAGEADJUSTMENT        = 0x0005 + MNOTE_NIKON1_TAG_BASE,
	MNOTE_NIKON1_TAG_CCDSENSITIVITY         = 0x0006 + MNOTE_NIKON1_TAG_BASE,
	MNOTE_NIKON1_TAG_WHITEBALANCE           = 0x0007 + MNOTE_NIKON1_TAG_BASE,
	MNOTE_NIKON1_TAG_FOCUS                  = 0x0008 + MNOTE_NIKON1_TAG_BASE,
	MNOTE_NIKON1_TAG_UNKNOWN_0X0009         = 0x0009 + MNOTE_NIKON1_TAG_BASE,
	MNOTE_NIKON1_TAG_DIGITALZOOM            = 0x000a + MNOTE_NIKON1_TAG_BASE,
	MNOTE_NIKON1_TAG_CONVERTER              = 0x000b + MNOTE_NIKON1_TAG_BASE,

	/* Olympus and some Sanyo */
	MNOTE_OLYMPUS_TAG_THUMBNAILIMAGE	= 0x0100,
	MNOTE_OLYMPUS_TAG_MODE			= 0x0200,
	MNOTE_OLYMPUS_TAG_QUALITY		= 0x0201,
	MNOTE_OLYMPUS_TAG_MACRO			= 0x0202,
	MNOTE_OLYMPUS_TAG_BWMODE		= 0x0203,
	MNOTE_OLYMPUS_TAG_DIGIZOOM		= 0x0204,
	MNOTE_OLYMPUS_TAG_FOCALPLANEDIAGONAL	= 0x0205,
	MNOTE_OLYMPUS_TAG_LENSDISTORTION	= 0x0206,
	MNOTE_OLYMPUS_TAG_VERSION		= 0x0207,
	MNOTE_OLYMPUS_TAG_INFO			= 0x0208,
	MNOTE_OLYMPUS_TAG_ID			= 0x0209,
	MNOTE_OLYMPUS_TAG_PRECAPTUREFRAMES	= 0x0300,
	MNOTE_OLYMPUS_TAG_WHITEBOARD		= 0x0301,
	MNOTE_OLYMPUS_TAG_ONETOUCHWB		= 0x0302,
	MNOTE_OLYMPUS_TAG_WHITEBALANCEBRACKET	= 0x0303,
	MNOTE_OLYMPUS_TAG_WHITEBALANCEBIAS	= 0x0304,
	MNOTE_OLYMPUS_TAG_UNKNOWN_5		= 0x0f00,
	MNOTE_OLYMPUS_TAG_UNKNOWN_4		= 0x0f04,
	MNOTE_OLYMPUS_TAG_SHUTTERSPEED		= 0x1000,
	MNOTE_OLYMPUS_TAG_ISOVALUE		= 0x1001,
	MNOTE_OLYMPUS_TAG_APERTUREVALUE		= 0x1002,
	MNOTE_OLYMPUS_TAG_BRIGHTNESSVALUE	= 0x1003,
	MNOTE_OLYMPUS_TAG_FLASHMODE		= 0x1004,
	MNOTE_OLYMPUS_TAG_FLASHDEVICE		= 0x1005,
	MNOTE_OLYMPUS_TAG_EXPOSURECOMP		= 0x1006,
	MNOTE_OLYMPUS_TAG_SENSORTEMPERATURE	= 0x1007,
	MNOTE_OLYMPUS_TAG_LENSTEMPERATURE	= 0x1008,
	MNOTE_OLYMPUS_TAG_LIGHTCONDITION	= 0x1009,
	MNOTE_OLYMPUS_TAG_FOCUSRANGE		= 0x100a,
	MNOTE_OLYMPUS_TAG_MANFOCUS		= 0x100b,
	MNOTE_OLYMPUS_TAG_FOCUSDIST		= 0x100c,
	MNOTE_OLYMPUS_TAG_ZOOMSTEPCOUNT		= 0x100d,
	MNOTE_OLYMPUS_TAG_FOCUSSTEPCOUNT	= 0x100e,
	MNOTE_OLYMPUS_TAG_SHARPNESS		= 0x100f,
	MNOTE_OLYMPUS_TAG_FLASHCHARGELEVEL	= 0x1010,
	MNOTE_OLYMPUS_TAG_COLORMATRIX		= 0x1011,
	MNOTE_OLYMPUS_TAG_BLACKLEVEL		= 0x1012,
	MNOTE_OLYMPUS_TAG_WBALANCE		= 0x1015,
	MNOTE_OLYMPUS_TAG_REDBALANCE		= 0x1017,
	MNOTE_OLYMPUS_TAG_BLUEBALANCE		= 0x1018,
	MNOTE_OLYMPUS_TAG_COLORMATRIXNUMBER	= 0x1019,
	MNOTE_OLYMPUS_TAG_SERIALNUMBER2		= 0x101a,
	MNOTE_OLYMPUS_TAG_FLASHEXPOSURECOMP	= 0x1023,
	MNOTE_OLYMPUS_TAG_INTERNALFLASHTABLE	= 0x1024,
	MNOTE_OLYMPUS_TAG_EXTERNALFLASHGVALUE	= 0x1025,
	MNOTE_OLYMPUS_TAG_EXTERNALFLASHBOUNCE	= 0x1026,
	MNOTE_OLYMPUS_TAG_EXTERNALFLASHZOOM	= 0x1027,
	MNOTE_OLYMPUS_TAG_EXTERNALFLASHMODE	= 0x1028,
	MNOTE_OLYMPUS_TAG_CONTRAST		= 0x1029,
	MNOTE_OLYMPUS_TAG_SHARPNESSFACTOR	= 0x102a,
	MNOTE_OLYMPUS_TAG_COLORCONTROL		= 0x102b,
	MNOTE_OLYMPUS_TAG_IMAGEWIDTH		= 0x102e,
	MNOTE_OLYMPUS_TAG_IMAGEHEIGHT		= 0x102f,
	MNOTE_OLYMPUS_TAG_SCENEDETECT		= 0x1030,
	MNOTE_OLYMPUS_TAG_COMPRESSIONRATIO	= 0x1034,
	MNOTE_OLYMPUS_TAG_PREVIEWIMAGEVALID	= 0x1035,
	MNOTE_OLYMPUS_TAG_AFRESULT		= 0x1038,
	MNOTE_OLYMPUS_TAG_CCDSCANMODE		= 0x1039,
	MNOTE_OLYMPUS_TAG_NOISEREDUCTION	= 0x103a,
	MNOTE_OLYMPUS_TAG_INFINITYLENSSTEP	= 0x103b,
	MNOTE_OLYMPUS_TAG_NEARLENSSTEP		= 0x103c,
	MNOTE_OLYMPUS_TAG_LIGHTVALUECENTER	= 0x103d,
	MNOTE_OLYMPUS_TAG_LIGHTVALUEPERIPHERY	= 0x103e,

	/* Sanyo */
	MNOTE_SANYO_TAG_SEQUENTIALSHOT		= 0x020e,
	MNOTE_SANYO_TAG_WIDERANGE		= 0x020f,
	MNOTE_SANYO_TAG_COLORADJUSTMENTMODE	= 0x0210,
	MNOTE_SANYO_TAG_QUICKSHOT		= 0x0213,
	MNOTE_SANYO_TAG_SELFTIMER		= 0x0214,
	MNOTE_SANYO_TAG_VOICEMEMO		= 0x0216,
	MNOTE_SANYO_TAG_RECORDSHUTTERRELEASE	= 0x0217,
	MNOTE_SANYO_TAG_FLICKERREDUCE		= 0x0218,
	MNOTE_SANYO_TAG_OPTICALZOOM		= 0x0219,
	MNOTE_SANYO_TAG_DIGITALZOOM		= 0x021b,
	MNOTE_SANYO_TAG_LIGHTSOURCESPECIAL	= 0x021d,
	MNOTE_SANYO_TAG_RESAVED			= 0x021e,
	MNOTE_SANYO_TAG_SCENESELECT		= 0x021f,
	MNOTE_SANYO_TAG_MANUALFOCUSDISTANCE	= 0x0223,
	MNOTE_SANYO_TAG_SEQUENCESHOTINTERVAL	= 0x0224
};
typedef enum _MnoteOlympusTag MnoteOlympusTag;

/* Don't use these definitions. They are here for compatibility only. */
#define MNOTE_OLYMPUS_TAG_UNKNOWN_1	MNOTE_OLYMPUS_TAG_BWMODE
#define MNOTE_OLYMPUS_TAG_UNKNOWN_2	MNOTE_OLYMPUS_TAG_FOCALPLANEDIAGONAL
#define MNOTE_OLYMPUS_TAG_UNKNOWN_3	MNOTE_OLYMPUS_TAG_LENSDISTORTION

const char *mnote_olympus_tag_get_name        (MnoteOlympusTag tag);
const char *mnote_olympus_tag_get_title       (MnoteOlympusTag tag);
const char *mnote_olympus_tag_get_description (MnoteOlympusTag tag);

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* __MNOTE_OLYMPUS_TAG_H__ */
