class Neuron
{
    static int ID = 1;

    private float radiusNormal = 0.4;
    private float radiusOver   = 0.45;
    private boolean isMouseOver = false;

    int id;
    PVector pos;
    Vector vec;

    Neuron(PVector p, int dim) {
        id = ID++;
        pos = new PVector(p.x, p.y);
        vec = new Vector(dim);
        for( int i = 0 ; i < vec.dim() ; i++ ) {
            vec.setAt(i, random(2) * 2 - 1);
        }
    }

    float distanceVec(Vector v) {
        return(vec.dist(v));
    }

    float distance2D(Neuron n) {
        return(pos.dist(n.pos));
    }

    void updateVec(Vector v) {
        vec.add(v);
    }

    void mouseOver(boolean yn) {
        isMouseOver = yn;
    }

    void checkMouseOver(float scale, float offset) {
        PVector drawPos = getDrawPos(scale, offset);
        float dist = drawPos.dist(new PVector(mouseX, mouseY));
        if( dist < scale * radiusNormal ) {
            mouseOver(true);
        } else {
            mouseOver(false);
        }
    }

    PVector getDrawPos(float scale, float offset) {
        float x = scale * pos.x + offset;
        float y = scale * pos.y + offset;
        return new PVector(x, y);
    }

    void draw(float scale, float offset) {
        noStroke();

        PVector colVec = new PVector(vec.getAt(0), vec.getAt(1), vec.getAt(2));
        colVec.normalize();
        fill(100 + colVec.x * 150, 100 + colVec.y * 150, 100 + colVec.z * 150);

        if( isMouseOver ) {
            ellipse(scale * pos.x + offset, scale * pos.y + offset,
                    scale * radiusOver   * 2, scale * radiusOver   * 2);
        } else {
            ellipse(scale * pos.x + offset, scale * pos.y + offset,
                    scale * radiusNormal * 2, scale * radiusNormal * 2);
        }
    }
}