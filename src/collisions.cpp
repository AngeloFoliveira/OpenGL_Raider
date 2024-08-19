
#include <algorithm>
#include "glm/vec4.hpp"
#include "glm/vec3.hpp"
#include "glm/mat4x4.hpp"

typedef struct cube{

    glm::vec3 min;
    glm::vec3 max;
} CUBE;

typedef struct sphere{

    float radius;
    glm::vec3 center;

} SPHERE;

typedef struct plane{

    glm::vec3 point;
    glm::vec3 normal;
} PLANE;





bool checkCollision(CUBE &cube, SPHERE &sphere)
{

}

bool checkCollision(CUBE &cube, PLANE &plane)
{

}

bool checkCollision(CUBE &cube, CUBE &cube2)
{

}