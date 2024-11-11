shader_type spatial;

uniform float amplitude = 0.1; // Amplitude de l'effet de vague
uniform float frequency = 2.0; // Fréquence de la vague
uniform float speed = 1.0;     // Vitesse du mouvement

void vertex() {
    // Déformation basée sur le temps et la position du sommet
    float wave = sin((VERTEX.y + TIME * speed) * frequency) * amplitude;

    // Ajouter l'effet de vague aux sommets, en fonction de la normale
    VERTEX += NORMAL * wave;
}
