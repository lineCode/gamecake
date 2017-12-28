

#shader "fun_draw_sprites"

uniform mat4 modelview;
uniform mat4 projection;
uniform vec2 projection_zxy;
uniform vec4 color;
uniform sampler2D tex;

#ifdef VERTEX_SHADER

attribute vec4 a_color;
attribute vec3 a_vertex;
attribute vec2 a_texcoord;

varying vec2  v_texcoord;
varying vec4  v_color;
 
void main()
{
//	gl_Position = projection * vec4( a_vertex , 1.0);
    gl_Position = projection * modelview * vec4( a_vertex.xy + projection_zxy*a_vertex.z , 0.0 , 1.0);
    gl_Position.z+=a_vertex.z/65536.0;
	v_texcoord=a_texcoord;
	v_color=a_color;
}


#endif
#ifdef FRAGMENT_SHADER

#if defined(GL_FRAGMENT_PRECISION_HIGH)
precision highp float; /* really need better numbers if possible */
#endif

varying vec2  v_texcoord;
varying vec4  v_color;


void main(void)
{
	gl_FragColor=texture2D(tex, v_texcoord).rgba*v_color*color;
	if((gl_FragColor.a)<0.0625) discard;
}

#endif

