# Generelized-predictive-control-GPC

The main objective is to set : a Generelized predictive controller (GPC).

Plant is :

fig.jpeg

We calculate the output predictions for 1 to 4 steps ahead :
y(k+j / k) = G(z)*u(k+j-1) + F(z)y(k)
where G(z) et F(z) are polynomials (and not transfer functions).
  

Specifications :
- Unitary control horizon.
- Future set-points equal to the current value.
- We should be able to easily modify the value of Lambda.
- It should also be possible to easily add a step disturbance at 
the output of the process. 
