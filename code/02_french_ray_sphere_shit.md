### french ray-sphere shit
simple but nice, found across internet wasteland...

```cpp
 
/* Auteur: Nicolas JANEY         */
/* nicolas.janey@univ-fcomte.fr  */
/* Avril 2001                    */
/* Calcul des rayons transmis    */
/* et reflechis sur une sphere   */

#include <stdio.h>
#include <math.h>

typedef struct coord_3D {
  float x ;
  float y ;
  float z ; } coord_3D ;

typedef struct direction_3D {
  float dx ;
  float dy ;
  float dz ; } direction_3D ;

typedef struct rayon {
  coord_3D pos ;
  direction_3D dir ; } rayon ;

/* En entree le rayon r teste. En sortie
le nombre d'intersection(s) */

int intersectionSphere(rayon *r) {
  float a = r->dir.dx*r->dir.dx +
            r->dir.dy*r->dir.dy +
            r->dir.dz*r->dir.dz ;
  float b = 2*(r->dir.dx*r->pos.x +
               r->dir.dy*r->pos.y +
               r->dir.dz*r->pos.z) ;
  float c = r->pos.x*r->pos.x +
            r->pos.y*r->pos.y +
            r->pos.z*r->pos.z - 1 ;
  float delta = b*b - 4*a*c ;
  if ( delta > 0 )
    return(2) ;
  if ( delta == 0 )
    return(1) ;
  return(0) ;
}

int posIntersectionSphere(rayon *r,
                          coord_3D *p) {
  float a = r->dir.dx*r->dir.dx +
            r->dir.dy*r->dir.dy +
            r->dir.dz*r->dir.dz ;
  float b = 2*(r->dir.dx*r->pos.x +
               r->dir.dy*r->pos.y +
               r->dir.dz*r->pos.z) ;
  float c = r->pos.x*r->pos.x +
            r->pos.y*r->pos.y +
            r->pos.z*r->pos.z - 1 ;
  float delta = b*b - 4*a*c ;
  if ( delta > 0 ) {
    float rcn =(float) pow((double) delta,0.5) ;
    float d = (-b-rcn)/2/a ;
    if ( d > 0 ) {
      p->x = r->pos.x + d * r->dir.dx ;
      p->y = r->pos.y + d * r->dir.dy ;
      p->z = r->pos.z + d * r->dir.dz ;
      return(1) ; }
      else {
      float d = (-b+rcn)/2/a ;
      if ( d > 0 ) {
        p->x = r->pos.x + d * r->dir.dx ;
        p->y = r->pos.y + d * r->dir.dy ;
        p->z = r->pos.z + d * r->dir.dz ;
        return(1) ; } }
    return(0) ; }
  if ( delta == 0 ) {
    float d = -b/2/a ;
    p->x = r->pos.x + d * r->dir.dx ;
    p->y = r->pos.y + d * r->dir.dy ;
    p->z = r->pos.z + d * r->dir.dz ;
    return(1) ; }
  return(0) ;
}

float produitScalaire(direction_3D *d1,
                      direction_3D *d2) {
  return(d1->dx*d2->dx +
         d1->dy*d2->dy +
         d1->dz*d2->dz) ;
}

void calculReflexion(rayon *r,
                     float d,
                     rayon *ref) {
  ref->pos.x = r->pos.x + d * r->dir.dx ;
  ref->pos.y = r->pos.y + d * r->dir.dy ;
  ref->pos.z = r->pos.z + d * r->dir.dz ;
  direction_3D n = { ref->pos.x,
                     ref->pos.y,
                     ref->pos.z } ;
  direction_3D i = { -r->dir.dx,
                     -r->dir.dy,
                     -r->dir.dz } ;
  float scal = produitScalaire(&n,&i) ;
  ref->dir.dx = 2 * n.dx * scal - i.dx ;
  ref->dir.dy = 2 * n.dy * scal - i.dy ;
  ref->dir.dz = 2 * n.dz * scal - i.dz ;
}

/* En entree le rayon r teste. En sortie
un booleen indiquant l'existence d'un
rayon reflechi, le rayon reflechi ref */

int rayonReflechiSphere(rayon *r,
                        rayon *ref) {
  float a = r->dir.dx*r->dir.dx +
            r->dir.dy*r->dir.dy +
            r->dir.dz*r->dir.dz ;
  float b = 2*(r->dir.dx*r->pos.x +
               r->dir.dy*r->pos.y +
               r->dir.dz*r->pos.z) ;
  float c = r->pos.x*r->pos.x +
            r->pos.y*r->pos.y +
            r->pos.z*r->pos.z - 1 ;
  float delta = b*b - 4*a*c ;
  a *= 2 ;
  if ( delta > 0 ) {
    float rcn =(float) pow((double) delta,0.5) ;
    float d = (-b-rcn)/a ;
    if ( d > 0 ) {
      calculReflexion(r,d,ref) ;
      return(1) ; }
      else {
      float d = (-b+rcn)/2 ;
      if ( d > 0 ) {
        calculReflexion(r,d,ref) ;
        return(1) ; } }
    return(0) ; }
  if ( delta == 0 ) {
    float d = -b/a ;
    calculReflexion(r,d,ref) ;
    return(1) ; }
  return(0) ;
}

int main(int argc,char **argv) {
/*  rayon r = { {3.0F,-0.2F,-0.3F},
              {-0.95F,0.22F,0.22F} } ;*/
/*  rayon r = { {3.0F,0.7071067811F,
                 0.7071067811F},
              {-1.0F,0.0F,0.0F} } ;*/
/*  rayon r = { {3.0F,0.7071067811F,0.0F},
              {-1.0F,0.0F,0.0F} } ;*/
  rayon r = { {3.0F,0.0F,0.7071067811F},
              {-1.0F,0.0F,0.0F} } ;
  printf("Rayon initial : %f %f %f\n",
         r.pos.x,r.pos.y,r.pos.z) ;
  printf("                %f %f %f\n",
         r.dir.dx,r.dir.dy,r.dir.dz) ;
  int n = intersectionSphere(&r) ;
  printf("Nombre intersections  : %d\n",n) ;
  coord_3D p ;
  int inter = posIntersectionSphere(&r,&p) ;
  if ( inter ) {
    printf("Pos intersection : %f %f %f\n",
           p.x,p.y,p.z) ; }
    else {
    printf("Pas d'intersection\n") ; }
  rayon ref ;
  inter = rayonReflechiSphere(&r,&ref) ;
  if ( inter ) {
    printf("Rayon reflechi : %f %f %f\n",
           ref.pos.x,ref.pos.y,ref.pos.z) ;
    printf("                 %f %f %f\n",
           ref.dir.dx,
           ref.dir.dy,
           ref.dir.dz) ; }
    else {
    printf("Pas de reflexion\n") ; }
  return(0);
}
```
