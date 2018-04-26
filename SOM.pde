class SOM
{
    protected int sizeX, sizeY, dimension;
    protected ArrayList neurons;
    protected float neighborRadius;

    SOM(int sx, int sy, int dim) {
        sizeX = sx;
        sizeY = sy;
        dimension = dim;

        neurons = new ArrayList();
        for( int x = 0 ; x < sizeX ; x++ ) {
            for( int y = 0 ; y < sizeY ; y++ ) {
                neurons.add(new Neuron(new PVector(x,y), dimension));
            }
        }
        neighborRadius = 0.5 * sqrt((sizeX * sizeX) + (sizeY * sizeY));
    }

    Neuron findNearestNeuronTo(Vector v) {
        Neuron neuron = null;
        float minDist = 0.0;
        if( v.dim() == dimension ) {
            neuron = (Neuron)neurons.get(0);
            minDist = neuron.distanceVec(v);
            for( int i = 1 ; i < neurons.size() ; i++ ) {
                Neuron n = (Neuron)neurons.get(i);
                float dist = n.distanceVec(v);
                if( dist < minDist ) {
                    neuron = n;
                    minDist = dist;
                }
            }
        }
        return neuron;
    }

    ArrayList getNeighborNeurons(Neuron cn) {
        ArrayList neighborNeurons = new ArrayList();
        for( int i = 0 ; i < neurons.size() ; i++ ) {
            Neuron n = (Neuron)neurons.get(i);
            if( cn.distance2D(n) < neighborRadius ) {
                neighborNeurons.add(n);
            }
        }
        return neighborNeurons;
    }

    Neuron getNeuronAt(int x, int y) {
        Neuron neuron = null;
        for( int i = 0 ; i < neurons.size() ; i++ ) {
            Neuron n = (Neuron)neurons.get(i);
            if( int(n.pos.x) == x && int(n.pos.y) == y ) {
                neuron = n;
                break;
            }
        }
        return neuron;
    }

    float gauss(float x) {
        return exp(-(x * x) / 0.5);
    }

    void updateVec(Vector v) {
        Neuron center = findNearestNeuronTo(v);
        updateSingleVec(center, center, v);
        
        ArrayList neighbors = getNeighborNeurons(center);
        for( int i = 0 ; i < neighbors.size() ; i++ ) {
            Neuron n = (Neuron)neighbors.get(i);
            updateSingleVec(center, n, v);
        }
    }

    protected void updateSingleVec(Neuron center, Neuron n, Vector v) {
        Vector disp = Vector.sub(v, n.vec);
        float dist2D = center.distance2D(n);
        float alpha = 0.8 * gauss(dist2D / neighborRadius);
        disp.mult(alpha);
        n.updateVec(disp);
    }

    Neuron getNearestNeuronToMouse() {
        float offset = getDrawOffset();
        float scale  = getDrawScale();
        Neuron neuron = null;
        float minDist = 0.0;
        for( int i = 0 ; i < neurons.size() ; i++ ) {
            Neuron n = (Neuron)neurons.get(i);
            PVector drawPos = n.getDrawPos(scale, offset);
            float dist = drawPos.dist(new PVector(mouseX, mouseY));
            if( neuron == null || dist < minDist ) {
                neuron = n;
                minDist = dist;
            }
        }
        return neuron;
    }

    void checkMouseOver() {
/*
        for( int i = 0 ; i < neurons.size() ; i++ ) {
            Neuron n = (Neuron)neurons.get(i);
            n.mouseOver(false);
        }
        Neuron nearestNeuron = getNearestNeuronToMouse();
        nearestNeuron.mouseOver(true);
*/
        float offset = getDrawOffset();
        float scale  = getDrawScale();
        for( int i = 0 ; i < neurons.size() ; i++ ) {
            Neuron n = (Neuron)neurons.get(i);
            n.checkMouseOver(scale, offset);
        }
    }

    float getDrawScale() {
        float offset = getDrawOffset();
        float scaleX = (width - offset * 2) / (sizeX - 1);
        float scaleY = (width - offset * 2) / (sizeY - 1);
        float scale = min(scaleX, scaleY);
        return scale;
    }

    float getDrawOffset() {
        return 50;
    }

    void draw() {
        float offset = getDrawOffset();
        float scale  = getDrawScale();
        for( int i = 0 ; i < neurons.size() ; i++ ) {
            Neuron n = (Neuron)neurons.get(i);
            n.draw(scale, offset);
        }
    }
}

