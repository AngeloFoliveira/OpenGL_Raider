#ifndef _COLLISIONS_H
#define _COLLISIONS_H

#include "glm/vec4.hpp"
#include "glm/vec3.hpp"
#include "glm/mat4x4.hpp"

namespace collisions
{

    typedef struct cube
    {
        glm::vec4 min;
        glm::vec4 max;
  //      float size; // Largura do cubo
    } CUBE;

    typedef struct sphere
    {
        glm::vec4 center;
        float radius;
    } SPHERE;

    typedef struct plane
    {
        glm::vec4 point;  // Um ponto no plano
        glm::vec4 normal; // Vetor normal do plano
    } PLANe;

    bool checkCollisionCubePlane(CUBE &cube, PLANe &plane);
    bool checkCollisionCubeSphere(CUBE &cube, SPHERE &sphere);
    bool checkCollisionCubeCube(CUBE &cube, CUBE &cube2);
    bool checkCollisionWithWalls(CUBE &lara1996);
    bool checkCollisionWithWalls2(CUBE &lara1996);
    float dotproduct(glm::vec4 u, glm::vec4 v);

}

#endif