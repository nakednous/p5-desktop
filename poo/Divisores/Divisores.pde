void setup() {
  printArray(divisores(245));
}


int[] divisores(int n) {
  int[] r = new int[cantidad(n)];
  int c = 0;
  for(int i=1; i<n; i++)
    if(n%i == 0)
      r[c++] = i;
  return r;
}

int cantidad(int n) {
  int r=0;
  for(int i=1; i<n; i++)
    if(n%i == 0)
      r++;
  return r;
}