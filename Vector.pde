class Vector
{
    float[] elements = null;

    Vector(int dim) {
        elements = new float[dim];
        for( int i = 0 ; i < elements.length ; i++ ) {
            elements[i] = 0.0;
        }
    }

    static Vector add(Vector x, Vector y) {
        Vector ans = new Vector(x.dim());
        ans.setVector(x);
        return ans.add(y);
    }

    static Vector sub(Vector x, Vector y) {
        Vector ans = new Vector(x.dim());
        ans.setVector(x);
        return ans.sub(y);
    }

    static Vector mult(Vector x, float c) {
        Vector ans = new Vector(x.dim());
        ans.setVector(x);
        return ans.mult(c);
    }

    float dist(Vector v) {
        float d = 0.0;
        for( int i = 0 ; i < elements.length ; i++ ) {
            d += (elements[i] - v.elements[i]) * (elements[i] - v.elements[i]);
        }
        return(sqrt(d));
    }

    Vector add(Vector v) {
        for( int i = 0 ; i < elements.length ; i++ ) {
            elements[i] += v.elements[i];
        }
        return this;
    }

    Vector sub(Vector v) {
        for( int i = 0 ; i < elements.length ; i++ ) {
            elements[i] -= v.elements[i];
        }
        return this;
    }

    Vector mult(float c) {
        for( int i = 0 ; i < elements.length ; i++ ) {
            elements[i] *= c;
        }
        return this;
    }

    Vector div(float c) {
        for( int i = 0 ; i < elements.length ; i++ ) {
            elements[i] /= c;
        }
        return this;
    }

    float mag() {
        float m = 0.0;
        for( int i = 0 ; i < elements.length ; i++ ) {
            m += (elements[i] * elements[i]);
        }
        return sqrt(m);
    }

    Vector normalize() {
        float m = this.mag();
        return this.div(m);
    }

    Vector setVector(Vector v) {
        for( int i = 0 ; i < elements.length ; i++ ) {
            elements[i] = v.elements[i];
        }
        return this;
    }

    Vector setArray(float[] v) {
        if( v.length == elements.length ) {
            for( int i = 0 ; i < elements.length ; i++ ) {
                elements[i] = v[i];
            }
        }
    }

    Vector setAt(int i, float v) {
        if( i < elements.length ) {
            elements[i] = v;
        }
        return this;
    }

    float getAt(int i) {
        float r = 0.0;
        if( i < elements.length ) {
            r = elements[i];
        }
        return r;
    }

    float[] getArray() {
        float[] r = new float[elements.length];
        for( int i = 0 ; i < elements.length ; i++ ) {
            r[i] = elements[i];
        }
        return r;
    }

    int dim() {
        return elements.length;
    }
}