#version 330 core

// Atributos de fragmentos recebidos como entrada ("in") pelo Fragment Shader.
// Neste exemplo, este atributo foi gerado pelo rasterizador como a
// interpolação da posição global e a normal de cada vértice, definidas em
// "shader_vertex.glsl" e "main.cpp".
in vec4 position_world;
in vec4 normal;

// Posição do vértice atual no sistema de coordenadas local do modelo.
in vec4 position_model;

// Coordenadas de textura obtidas do arquivo OBJ (se existirem!)
in vec2 texcoords;

// Matrizes computadas no código C++ e enviadas para a GPU
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

// Identificador que define qual objeto está sendo desenhado no momento
#define PLANE 0
#define CHAO 1
#define MAOSLARAVELHA 2
#define PISTOLASLARAVELHA 3
#define ROSTOLARAVELHA 4
#define CABELOLARAVELHA 5
#define CORPOLARAVELHA 6 //???
#define COLDRELARAVELHA 7

//#define LARAATUAL 999


uniform int object_id;

// Parâmetros da axis-aligned bounding box (AABB) do modelo
uniform vec4 bbox_min;
uniform vec4 bbox_max;

// Variáveis para acesso das imagens de textura
uniform sampler2D TextureImage0;
uniform sampler2D TextureImage1;
uniform sampler2D TextureImage2;
uniform sampler2D TextureImage3;
uniform sampler2D TextureImage4;
uniform sampler2D TextureImage5;
uniform sampler2D TextureImage6;
uniform sampler2D TextureImage7;



// O valor de saída ("out") de um Fragment Shader é a cor final do fragmento.
out vec4 color;

// Constantes
#define M_PI   3.14159265358979323846
#define M_PI_2 1.57079632679489661923

void main()
{
    // Obtemos a posição da câmera utilizando a inversa da matriz que define o
    // sistema de coordenadas da câmera.
    vec4 origin = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 camera_position = inverse(view) * origin;

    // O fragmento atual é coberto por um ponto que percente à superfície de um
    // dos objetos virtuais da cena. Este ponto, p, possui uma posição no
    // sistema de coordenadas global (World coordinates). Esta posição é obtida
    // através da interpolação, feita pelo rasterizador, da posição de cada
    // vértice.
    vec4 p = position_world;

    // Normal do fragmento atual, interpolada pelo rasterizador a partir das
    // normais de cada vértice.
    vec4 n = normalize(normal);

    // Fonte de luz (ponto)
    vec4 l2 = vec4(0.0f,50.0f,0.0f,1.0f); //CERTO

    vec4 ponto_v = vec4(0.0,-1.0,0.0,1.0); //CERTO

    vec4 v2 = ponto_v-l2;

    // Vetor que define o sentido da fonte de luz em relação ao ponto atual.
    vec4 l = normalize(l2-p); //CERTO

    //  vec4 l = normalize(camera_position-p);

    // Vetor que define o sentido da câmera em relação ao ponto atual.
    vec4 v = normalize(camera_position - p);

    float calculo = dot(normalize(p-l),normalize(v2));

    // Vetor que define o sentido da reflexão especular ideal.
    vec4 r = vec4(-l + 2*n*dot(n,l)); // PREENCHA AQUI o vetor de reflexão especular ideal

    // Parâmetros que definem as propriedades espectrais da superfície
    vec3 Kd; // Refletância difusa
    vec3 Ks; // Refletância especular
    vec3 Ka; // Refletância ambiente
    float q; // Expoente especular para o modelo de iluminação de Phong

    // Coordenadas de textura U e V
    float U = 0.0;
    float V = 0.0;


    if ( object_id == CHAO)
    {
        U = texcoords.x;
        V = texcoords.y;
        Kd = vec3(1,1,1);
        Ks = vec3(1,1,1);
        Ka = vec3(0.1,0.1,0.1);
        q = 20.0;
    }
    if ( object_id == PLANE )
    {
        // Coordenadas de textura do plano, obtidas do arquivo OBJ.
        U = texcoords.x;
        V = texcoords.y;
        Kd = vec3(0.2,0.2,0.2);
        Ks = vec3(0.3,0.3,0.3);
        Ka = vec3(0.1,0.1,0.1);
        q = 20.0;
    }
    if ( object_id == CORPOLARAVELHA)

    {
        U = texcoords.x;
        V = texcoords.y;

        Kd = vec3(0.698039, 0.698039, 0.698039);
        Ks = vec3(0.0,0.0,0.0);
        Ka = vec3(0.0,0.0,0.0);
        q = 9.84916;
    }
    if ((object_id == PISTOLASLARAVELHA)
        ||(object_id == COLDRELARAVELHA))
    {
        U = texcoords.x;
        V = texcoords.y;

        Kd = vec3(0.698039, 0.698039, 0.698039);
        Ks = vec3(0.0,0.0,0.0);
        Ka = vec3(0.0,0.0,0.0);
        q = 9.84916;
    }
    if (object_id == ROSTOLARAVELHA)
    {
        U = texcoords.x;
        V = texcoords.y + 1;

        Kd = vec3(0.698039, 0.698039, 0.698039);
        Ks = vec3(0.0,0.0,0.0);
        Ka = vec3(0.0,0.0,0.0);
        q = 9.84916;
    }
    if ((object_id == MAOSLARAVELHA)||(object_id == CABELOLARAVELHA)) //n funciona ainda (perna/braço e cabelo)
    {
        U = texcoords.x;
        V = texcoords.y;

        Kd = vec3(0.698039, 0.698039, 0.698039);
        Ks = vec3(0.0,0.0,0.0);
        Ka = vec3(0.0,0.0,0.0);
        q = 9.84916;
    }





    // Espectro da fonte de iluminação
    vec3 I = vec3(1.0,1.0,1.0); // PREENCH AQUI o espectro da fonte de luz

    // Espectro da luz ambiente
    vec3 Ia = vec3(1,1,1); // PREENCHA AQUI o espectro da luz ambiente

    // Termo difuso utilizando a lei dos cossenos de Lambert
    vec3 lambert_diffuse_term = vec3(Kd*I*max(0,dot(n,l))) ; // PREENCHA AQUI o termo difuso de Lambert

    // Termo ambiente
    vec3 ambient_term = vec3(Ka*Ia); // PREENCHA AQUI o termo ambiente

    // Termo especular utilizando o modelo de iluminação de Phong
    vec3 phong_specular_term  = vec3(Ks*I*max(0,pow(dot(r,v),q))); // PREENCH AQUI o termo especular de Phong


    // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
    vec3 Kd0 = texture(TextureImage0, vec2(U,V)).rgb;
    vec3 Kd1 = texture(TextureImage1, vec2(U,V)).rgb;
    vec3 Kd2 = texture(TextureImage2, vec2(U,V)).rgb;
    vec3 Kd3 = texture(TextureImage3, vec2(U,V)).rgb;
    vec3 Kd4 = texture(TextureImage4, vec2(U,V)).rgb;
    vec3 Kd5 = texture(TextureImage5, vec2(U,V)).rgb;
    vec3 Kd6 = texture(TextureImage6, vec2(U,V)).rgb;
    vec3 Kd7 = texture(TextureImage7, vec2(U,V)).rgb;

    // Equação de Iluminação
    float lambert = max(0,dot(n,l));

    color.a = 1;


    if (calculo>= cos(180) && object_id == PLANE)
        color.rgb = Kd0 * (lambert + 0.01);
        else if (calculo>= cos(180) && object_id == CHAO)
            color.rgb = Kd1 * (lambert + 0.01);
            else if (object_id == MAOSLARAVELHA)
            color.rgb = Kd2 * (lambert + 0.01);
            else if (object_id == PISTOLASLARAVELHA)
                color.rgb = Kd3 * (lambert + 0.01);
                else if (object_id == ROSTOLARAVELHA)
                    color.rgb = Kd4 * (lambert + 0.01);
                    else if (object_id == CABELOLARAVELHA)
                        color.rgb = Kd5 * (lambert + 0.01);
                        else if (object_id == CORPOLARAVELHA)
                            color.rgb = Kd6 * (lambert + 0.01);
                            else if (object_id == COLDRELARAVELHA)
                                color.rgb = Kd7 * (lambert + 0.01);

                                else
                                    color.rgb = ambient_term;
                                    // Cor final com correção gamma, considerando monitor sRGB.
                                    // Veja https://en.wikipedia.org/w/index.php?title=Gamma_correction&oldid=751281772#Windows.2C_Mac.2C_sRGB_and_TV.2Fvideo_standard_gammas
                                    color.rgb = pow(color.rgb, vec3(1.0,1.0,1.0)/2.2);
                                    }

