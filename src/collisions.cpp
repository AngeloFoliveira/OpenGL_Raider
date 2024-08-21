#include "collisions.h"
#include <algorithm>

namespace collisions
{
    //FONTE CHATGPT
    bool checkCollisionCubePlane(CUBE &cube, PLANe &plane)
    {
        // Checar se o plano colide com o cubo
        glm::vec4 vertices[8] = {
            cube.min,
            glm::vec4(cube.max.x, cube.min.y, cube.min.z, 1.0f),
            glm::vec4(cube.min.x, cube.max.y, cube.min.z, 1.0f),
            glm::vec4(cube.min.x, cube.min.y, cube.max.z, 1.0f),
            glm::vec4(cube.max.x, cube.max.y, cube.min.z, 1.0f),
            glm::vec4(cube.min.x, cube.max.y, cube.max.z, 1.0f),
            glm::vec4(cube.max.x, cube.min.y, cube.max.z, 1.0f),
            cube.max};

        int front = 0, back = 0;
        for (int i = 0; i < 8; i++)
        {
            glm::vec4 vectorToPoint = vertices[i] - plane.point;
            float distance = dotproduct(plane.normal, vectorToPoint);
            if (distance > 0)
                front++;
            else if (distance < 0)
                back++;
        }

        // Se há vértices na frente e atrás do plano, há colisão
        return front > 0 && back > 0;
    }
    //FONTE CHATGPT
    bool checkCollisionWithWalls(CUBE &lara1996)
    {
        // Definição das paredes
        PLANe planeWest = {glm::vec4(0.0f, 78.0f, 80.0f, 1.0f), glm::vec4(0.0f, 0.0f, -1.0f, 0.0f)};  // Oeste
        PLANe planeSouth = {glm::vec4(-80.0f, 78.0f, 0.0f, 1.0f), glm::vec4(1.0f, 0.0f, 0.0f, 0.0f)}; // Sul
        PLANe planeEast = {glm::vec4(0.0f, 78.0f, -80.0f, 1.0f), glm::vec4(0.0f, 0.0f, 1.0f, 0.0f)};  // Leste
        PLANe planeNorth = {glm::vec4(80.0f, 78.0f, 0.0f, 1.0f), glm::vec4(-1.0f, 0.0f, 0.0f, 0.0f)}; // Norte

        // Testa colisão com cada uma das paredes
        if (checkCollisionCubePlane(lara1996, planeWest) ||
            checkCollisionCubePlane(lara1996, planeSouth) ||
            checkCollisionCubePlane(lara1996, planeEast) ||
            checkCollisionCubePlane(lara1996, planeNorth))
        {
            return true;
        }
        return false;
    }
    //FONTE CHATGPT
    bool checkCollisionCubeSphere(CUBE &cube, SPHERE &sphere)
    {
        // Encontra o ponto mais próximo no cubo ao centro da esfera
        glm::vec4 closestPoint = glm::vec4(
            std::max(cube.min.x, std::min(sphere.center.x, cube.max.x)),
            std::max(cube.min.y, std::min(sphere.center.y, cube.max.y)),
            std::max(cube.min.z, std::min(sphere.center.z, cube.max.z)),
            1.0f);

        // Calcula a distância entre o ponto mais próximo e o centro da esfera
        glm::vec4 difference = closestPoint - sphere.center;
        float distance = glm::length(difference);

        // Se a distância for menor ou igual ao raio, há colisão
        return distance <= sphere.radius;
    }
    //FONTE CHATGPT
    bool checkCollisionCubeCube(CUBE &cube1, CUBE &cube2)
    {
        // Checa se há sobreposição em todos os eixos
        bool overlapX = cube1.min.x <= cube2.max.x && cube1.max.x >= cube2.min.x;
        bool overlapY = cube1.min.y <= cube2.max.y && cube1.max.y >= cube2.min.y;
        bool overlapZ = cube1.min.z <= cube2.max.z && cube1.max.z >= cube2.min.z;

        // Se há sobreposição em todos os eixos, há colisão
        return overlapX && overlapY && overlapZ;
    }

    // Produto escalar vetor u e v
    float dotproduct(glm::vec4 u, glm::vec4 v)
    {
        float u1 = u.x;
        float u2 = u.y;
        float u3 = u.z;
        float v1 = v.x;
        float v2 = v.y;
        float v3 = v.z;

        return u1 * v1 + u2 * v2 + u3 * v3;
    }

    bool checkCollisionWithWalls2(CUBE &lara1996)
    {
        // Definição das paredes
        CUBE parede0 = {glm::vec4(55.0f, -2.0f, 20.0f, 1.0f), glm::vec4(70.0f, 18.0f, 70.0f, 1.0f)};
        CUBE parede1 = {glm::vec4(45.0f, -2.0f, 60.0f, 1.0f), glm::vec4(55.0f, 18.0f, 70.0f, 1.0f)};
        CUBE parede2 = {glm::vec4(30.0f, -2.0f, 40.0f, 1.0f), glm::vec4(45.0f, 18.0f, 70.0f, 1.0f)};
        CUBE parede3 = {glm::vec4(30.0f, -2.0f, 20.0f, 1.0f), glm::vec4(60.0f, 18.0f, 30.0f, 1.0f)};
        CUBE parede4 = {glm::vec4(0.0f, -2.0f, 40.0f, 1.0f), glm::vec4(20.0f, 18.0f, 70.0f, 1.0f)};
        CUBE parede5 = {glm::vec4(-10.0f, -2.0f, 60.0f, 1.0f), glm::vec4(0.0f, 18.0f, 70.0f, 1.0f)};
        CUBE parede6 = {glm::vec4(-30.0f, -2.0f, 40.0f, 1.0f), glm::vec4(-10.0f, 18.0f, 70.0f, 1.0f)};
        CUBE parede7 = {glm::vec4(-60.0f, -2.0f, 30.0f, 1.0f), glm::vec4(-40.0f, 18.0f, 70.0f, 1.0f)};
        CUBE parede8 = {glm::vec4(-80.0f, -2.0f, 30.0f, 1.0f), glm::vec4(-60.0f, 18.0f, 45.0f, 1.0f)};
        CUBE parede9 = {glm::vec4(-30.0f, -2.0f, 20.0f, 1.0f), glm::vec4(20.0f, 18.0f, 30.0f, 1.0f)};
        CUBE parede10 = {glm::vec4(0.0f, -2.0f, -80.0f, 1.0f), glm::vec4(20.0f, 18.0f, -30.0f, 1.0f)};
        CUBE parede11 = {glm::vec4(0.0f, -2.0f, -20.0f, 1.0f), glm::vec4(20.0f, 18.0f, 20.0f, 1.0f)};
        CUBE parede12 = {glm::vec4(-30.0f, -2.0f, -65.0f, 1.0f), glm::vec4(0.0f, 18.0f, -45.0f, 1.0f)};
        CUBE parede13 = {glm::vec4(-30.0f, -2.0f, -45.0f, 1.0f), glm::vec4(-10.0f, 18.0f, 10.0f, 1.0f)};
        CUBE parede14 = {glm::vec4(30.0f, -2.0f, -80.0f, 1.0f), glm::vec4(45.0f, 18.0f, -65.0f, 1.0f)};
        CUBE parede15 = {glm::vec4(30.0f, -2.0f, -65.0f, 1.0f), glm::vec4(70.0f, 18.0f, -50.0f, 1.0f)};
        CUBE parede16 = {glm::vec4(60.0f, -2.0f, -50.0f, 1.0f), glm::vec4(70.0f, 18.0f, 10.0f, 1.0f)};
        CUBE parede17 = {glm::vec4(30.0f, -2.0f, -40.0f, 1.0f), glm::vec4(50.0f, 18.0f, 10.0f, 1.0f)};
        CUBE parede18 = {glm::vec4(-80.0f, -2.0f, -20.0f, 1.0f), glm::vec4(-40.0f, 18.0f, 0.0f, 1.0f)};
        CUBE parede19 = {glm::vec4(-70.0f, -2.0f, 0.0f, 1.0f), glm::vec4(-60.0f, 18.0f, 20.0f, 1.0f)};
        CUBE parede20 = {glm::vec4(-50.0f, -2.0f, 0.0f, 1.0f), glm::vec4(-40.0f, 18.0f, 20.0f, 1.0f)};

        // Testa colisão com cada uma das paredes
        if (checkCollisionCubeCube(lara1996, parede0) || checkCollisionCubeCube(lara1996, parede1) || checkCollisionCubeCube(lara1996, parede2) || checkCollisionCubeCube(lara1996, parede3) ||
            checkCollisionCubeCube(lara1996, parede4) || checkCollisionCubeCube(lara1996, parede5) || checkCollisionCubeCube(lara1996, parede6) || checkCollisionCubeCube(lara1996, parede7) ||
            checkCollisionCubeCube(lara1996, parede8) || checkCollisionCubeCube(lara1996, parede9) || checkCollisionCubeCube(lara1996, parede10) || checkCollisionCubeCube(lara1996, parede11) ||
            checkCollisionCubeCube(lara1996, parede12) || checkCollisionCubeCube(lara1996, parede13) || checkCollisionCubeCube(lara1996, parede14) || checkCollisionCubeCube(lara1996, parede15)|| 
            checkCollisionCubeCube(lara1996, parede16) || checkCollisionCubeCube(lara1996, parede17) || checkCollisionCubeCube(lara1996, parede18) || checkCollisionCubeCube(lara1996, parede19) ||
            checkCollisionCubeCube(lara1996, parede20))

        {
            return true;
        }
        return false;
    }

}
