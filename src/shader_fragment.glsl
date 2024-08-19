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
#define MURO 8
#define CRANIO 9
#define DENTE 10
#define ESTATUA 11
#define BOCALARANOVA 12
#define BOTALARANOVA 13
#define CABELO1LARANOVA 14
#define CABELO2LARANOVA 15
#define CABELO3LARANOVA 16
#define CABELO4LARANOVA 17
#define CABELO5LARANOVA 18
#define CABELO6LARANOVA 19
#define CALCALARANOVA 20
#define CAMISALARANOVA 21
#define CAMISA2LARANOVA 22
#define CAMISA3LARANOVA 23
#define CILIOLARANOVA 24
#define COLDRELARANOVA 25
#define FERRAMENTASLARANOVA 26
#define LUVALARANOVA 27
#define MAOLARANOVA 28
#define OLHOLARANOVA 29
#define ROSTOLARANOVA 30
#define ROSTO2LARANOVA 31
#define ROSTO3LARANOVA 32
#define SHADLARANOVA 33
#define SOBRANCELHALARANOVA 34
#define CALCA2LARANOVA 35

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
uniform sampler2D TextureImage8;
uniform sampler2D TextureImage9;
uniform sampler2D TextureImage10;
uniform sampler2D TextureImage11;
uniform sampler2D TextureImage12;
uniform sampler2D TextureImage13;
uniform sampler2D TextureImage14;
uniform sampler2D TextureImage15;
uniform sampler2D TextureImage16;
uniform sampler2D TextureImage17;
uniform sampler2D TextureImage18;
uniform sampler2D TextureImage19;
uniform sampler2D TextureImage20;
uniform sampler2D TextureImage21;
uniform sampler2D TextureImage22;
uniform sampler2D TextureImage23;
uniform sampler2D TextureImage24;
uniform sampler2D TextureImage25;
uniform sampler2D TextureImage26;
uniform sampler2D TextureImage27;
uniform sampler2D TextureImage28;
uniform sampler2D TextureImage29;
uniform sampler2D TextureImage30;


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
    vec4 l2 = vec4(0.0f,100.0f,0.0f,1.0f); //CERTO

    vec4 ponto_v = vec4(0.0,0.0,0.0,1.0); //CERTO

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


if ( object_id == MURO)
    {
        float minx = bbox_min.x;
        float maxx = bbox_max.x;

        float miny = bbox_min.y;
        float maxy = bbox_max.y;

        float minz = bbox_min.z;
        float maxz = bbox_max.z;


        if(p[1]==18.0f)
        {
            U = ((position_model[0]-minx)/(maxx-minx))*5.0f;
            V = ((position_model[2]-minz)/(maxz-minz))*5.0f;
        }
        else if (p[2]== 70.0f||p[2]== 30.0f||p[2] == 45.0f
                ||p[2]== -30.0f||p[2] == 20.0f||p[2]==-45.0f
                ||p[2]==10.0f||p[2]==-65.0f||p[2]==-50.0f
                ||p[2]==0.0f||p[2]==60.0f||p[2]==40.0f
                ||p[2]==-20.0f||p[2]==-40.0f){
            U = ((position_model[0]-minx)/(maxx-minx))*5.0f;
            V = ((position_model[1]-miny)/(maxy-miny))*5.0f;
        }
        else {
            U = ((position_model[1]-miny)/(maxy-miny))*5.0f;
            V = ((position_model[2]-minz)/(maxz-minz))*5.0f;
        }


        Kd = vec3(1,1,1);
        Ks = vec3(1,1,1);
        Ka = vec3(0.1,0.1,0.1);
        q = 20.0;
    }
    if ( object_id == CHAO)
    {

        float minx = bbox_min.x;
        float maxx = bbox_max.x;

        float minz = bbox_min.z;
        float maxz = bbox_max.z;

        U = ((position_model[0]-minx)/(maxx-minx))*5.0f;
        V = ((position_model[2]-minz)/(maxz-minz))*5.0f;

        Kd = vec3(1,1,1);
        Ks = vec3(1,1,1);
        Ka = vec3(0.1,0.1,0.1);
        q = 20.0;
    }
    if ( object_id == PLANE )
    {
        float minx = bbox_min.x;
        float maxx = bbox_max.x;

        float minz = bbox_min.z;
        float maxz = bbox_max.z;

        U = ((position_model[0]-minx)/(maxx-minx))*5.0f;
        V = ((position_model[2]-minz)/(maxz-minz))*5.0f;

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
        V = texcoords.y;

        Kd = vec3(0.698039, 0.698039, 0.698039);
        Ks = vec3(0.0,0.0,0.0);
        Ka = vec3(0.0,0.0,0.0);
        q = 9.84916;
    }

    if ((object_id == MAOSLARAVELHA)||(object_id == CABELOLARAVELHA))
    {
        U = texcoords.x;
        V = texcoords.y;

        Kd = vec3(0.0,0.0,0.0);
        Ks = vec3(0.5,0.5,0.5);
        Ka = vec3(1.0,1.0,1.0);
        q = 10;
    }
   if (object_id == CRANIO)
   {
        U = texcoords.x;
        V = texcoords.y;

        Kd = vec3(1,1,1);
        Ks = vec3(1,1,1);
        Ka = vec3(0.1260,0.1260,0.1260);
        q = 28;
   }
   if (object_id == DENTE)
   {
        U = texcoords.x;
        V = texcoords.y;

        Kd = vec3(1,1,1);
        Ks = vec3(0.4230f,0.4230f,0.4230f);
        Ka = vec3(1,1,1);
        q = 24;
   }
   if (object_id == ESTATUA)
   {
        U = texcoords.x;
        V = texcoords.y;

        Kd = vec3(1,1,1);
        Ks = vec3(0.7f,0.6341f,0.4365f);
        Ka = vec3(1,1,1);
        q = 60;
   }
   for (int i = 12; i < 36; i++)
   {
    /*float minx = bbox_min.x;
        float maxx = bbox_max.x;

        float miny = bbox_min.y;
        float maxy = bbox_max.y;

        float minz = bbox_min.z;
        float maxz = bbox_max.z;
        */
        if (object_id == i)
        {
                U = texcoords.x;
                V = texcoords.y;

                Kd = vec3(0.698039f,0.698039f,0.698039f);
                Ks = vec3(0,0,0);
                Ka = vec3(0,0,0);
                q = 9.84916;
        }
   }




    // Espectro da fonte de iluminação
    vec3 I = vec3(1.0,1.0,1.0); // PREENCH AQUI o espectro da fonte de luz

    // Espectro da luz ambiente
    vec3 Ia = vec3(0.5,0.5,0.5); // PREENCHA AQUI o espectro da luz ambiente

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
    vec3 Kd8 = texture(TextureImage8, vec2(U,V)).rgb;
    vec3 Kd9 = texture(TextureImage9, vec2(U,V)).rgb;
    vec3 Kd10 = texture(TextureImage10, vec2(U,V)).rgb;
    vec3 Kd11 = texture(TextureImage11, vec2(U,V)).rgb;
    vec3 Kd12 = texture(TextureImage12, vec2(U,V)).rgb;
    vec3 Kd13 = texture(TextureImage13, vec2(U,V)).rgb;
    vec3 Kd14 = texture(TextureImage14, vec2(U,V)).rgb;
    vec3 Kd15 = texture(TextureImage15, vec2(U,V)).rgb;
    vec3 Kd16 = texture(TextureImage16, vec2(U,V)).rgb;
    vec3 Kd17 = texture(TextureImage17, vec2(U,V)).rgb;
    vec3 Kd18 = texture(TextureImage18, vec2(U,V)).rgb;
    vec3 Kd19 = texture(TextureImage19, vec2(U,V)).rgb;
    vec3 Kd20 = texture(TextureImage20, vec2(U,V)).rgb;
    vec3 Kd21 = texture(TextureImage21, vec2(U,V)).rgb;
    vec3 Kd22 = texture(TextureImage22, vec2(U,V)).rgb;
    vec3 Kd23 = texture(TextureImage23, vec2(U,V)).rgb;
    vec3 Kd24 = texture(TextureImage24, vec2(U,V)).rgb;
    vec3 Kd25 = texture(TextureImage25, vec2(U,V)).rgb;
    vec3 Kd26 = texture(TextureImage26, vec2(U,V)).rgb;
    vec3 Kd27 = texture(TextureImage27, vec2(U,V)).rgb;
    vec3 Kd28 = texture(TextureImage28, vec2(U,V)).rgb;
    vec3 Kd29 = texture(TextureImage29, vec2(U,V)).rgb;
    vec3 Kd30 = texture(TextureImage30, vec2(U,V)).rgb;

    // Equação de Iluminação
    float lambert = max(0,dot(n,l));

    color.a = 1;


    if (calculo>= cos(180) && object_id == PLANE)
        color.rgb = Kd0 * (lambert + 0.01);
        else if (object_id == CHAO)
            color.rgb = Kd1;
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
                                    else if (object_id == MURO)
                                        color.rgb = Kd8 * (lambert + 0.01);
                                        else if (object_id == CRANIO)
                                            color.rgb = Kd9 * (lambert+0.01);
                                            else if (object_id == DENTE)
                                                color.rgb = Kd10 * (lambert+0.01);
                                                    else if (object_id == ESTATUA)
                                                    color.rgb = Kd11 * (lambert+0.01);
                                                    else if (object_id == BOCALARANOVA)
                                                    color.rgb = Kd12 *(lambert +0.01);
                                                    else if (object_id == BOTALARANOVA)
                                                    color.rgb = Kd13 *(lambert +0.01);
                                                    else if (object_id == CABELO1LARANOVA)
                                                    color.rgb = Kd14 *(lambert +0.01);
                                                    else if (object_id == CABELO2LARANOVA)
                                                    color.rgb = Kd15 *(lambert +0.01);
                                                    else if (object_id == CABELO3LARANOVA)
                                                    color.rgb = Kd16 *(lambert +0.01);
                                                    else if (object_id == CABELO4LARANOVA)
                                                    color.rgb = Kd17 *(lambert +0.01);
                                                    else if (object_id == CABELO5LARANOVA)
                                                    color.rgb = Kd18 *(lambert +0.01);
                                                    else if (object_id == CABELO6LARANOVA)
                                                    color.rgb = Kd19 *(lambert +0.01);
                                                    else if (object_id == CALCALARANOVA)
                                                    color.rgb = Kd20 *(lambert +0.01);
                                                    else if (object_id == CALCA2LARANOVA)
                                                    color.rgb = Kd20 *(lambert +0.01);
                                                    else if (object_id == CAMISA3LARANOVA)
                                                    color.rgb = Kd21 *(lambert +0.01);
                                                    else if (object_id == CAMISA2LARANOVA)
                                                    color.rgb = Kd21 *(lambert +0.01);
                                                    else if (object_id == CAMISALARANOVA)
                                                    color.rgb = Kd21 *(lambert +0.01);
                                                    else if (object_id == CILIOLARANOVA)
                                                    color.rgb = Kd22 *(lambert +0.01);
                                                    else if (object_id == COLDRELARANOVA)
                                                    color.rgb = Kd23 *(lambert +0.01);
                                                    else if (object_id == FERRAMENTASLARANOVA)
                                                    color.rgb = Kd24 *(lambert +0.01);
                                                    else if (object_id == LUVALARANOVA)
                                                    color.rgb = Kd25 *(lambert +0.01);
                                                    else if (object_id == MAOLARANOVA)
                                                    color.rgb = Kd26 *(lambert +0.01);
                                                    else if (object_id == OLHOLARANOVA)
                                                    color.rgb = Kd27 *(lambert +0.01);
                                                    else if (object_id == ROSTO3LARANOVA)
                                                    color.rgb = Kd28 *(lambert +0.01);
                                                    else if (object_id == ROSTO2LARANOVA)
                                                    color.rgb = Kd28 *(lambert +0.01);
                                                    else if (object_id == ROSTOLARANOVA)
                                                    color.rgb = Kd28 *(lambert +0.01);
                                                    else if (object_id == SHADLARANOVA)
                                                    color.rgb = Kd29 *(lambert +0.01);
                                                    else if (object_id == SOBRANCELHALARANOVA)
                                                    color.rgb = Kd30 *(lambert +0.01);
                                                    else
                                                        color.rgb = ambient_term;
                                                        // Cor final com correção gamma, considerando monitor sRGB.
                                                        // Veja https://en.wikipedia.org/w/index.php?title=Gamma_correction&oldid=751281772#Windows.2C_Mac.2C_sRGB_and_TV.2Fvideo_standard_gammas
                                                        color.rgb = pow(color.rgb, vec3(1.0,1.0,1.0)/2.2);
                                                        }

