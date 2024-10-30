The following derivation follows Mechel's approach with some of my own tweaking to the final implementation. Given a rectangular element placed in a hard baffle wall with an obliquely incident plane wave moving towards the surface, the term field excited refers to a vibration pattern set in motion by a wave propagating towards the opening.

![Alt text](img.jpg?raw=true "illustration")

The object here is a rectangle A with side lengths a and b on a hard baffle wall. The recatangle is excited by a plan wave with a polar incident angle of $\theta$ and an azimuthal angle of $\phi$. The average velocity pattern on the surface is:

$v(x,y) = V_0 \cdot e^{-i(k_x x+k_y y)}$

$k_x = k_0 \cdot \sin(\theta) \cdot \cos(\phi) = k_0 \cdot \mu_x $

$k_y = k_0 \cdot \sin(\theta) \cdot \sin(\phi) = k_0 \cdot \mu_y$

Following Mechel's calculations, we have the fact that $|v(x,y)| = \text{constant}$ on the surface $A$ and that the radiation impedance follows from the average field impedance. The Fourier transform of the velocity distribution leads to a form with a double integration:

$V(k_1,k_2) = \iint\limits_A{v(x_0 , y_0) e^{-i (k_1 x + k_2 y_0)}} \, dx_0 \, dy_0$

$V_0 a b \cdot \frac{\sin((k_1+k_x)a/2)}{(k_1+k_x)a/2}$

$ \cdot \frac{}{} $
$\sin((k_2+k_y)b/2)$
$(k_2+k_y)b/2$

using $\alpha_1 = k_1/k_0$ and $\alpha_2 = k_2/k_0$:

$\frac{Z_r}{Z_0} = \frac{k_0 a \cdot k_0 b}{4 \pi^2} \iint\limits_{-\infty}^{\infty}\left( \frac{\sin(\mu_x - \alpha_1)k_0 a/2}{(\mu_x - \alpha_1)k_0 a/2} \right)^2 \left( \frac{\sin(\mu_y - \alpha_2)k_0 b/2}{(\mu_y - \alpha_2)k_0 b/2} \right)^2 \frac{d \alpha_1 \, d\alpha_2}{\sqrt{1-\alpha_1^2 -\alpha_2^2}} $

This could be translated into:

$\frac{Z_r}{Z_0} = \frac{2i}{\pi k_0 a \cdot k_0 b} \int_{x=0}^{k_0 a} dx \int_0^{k_0 b} (k_0 a-x)(k_0 b-y)\cos(\mu_x x) \cos(\mu_y y) \frac{e^{-i \sqrt{x^2 +y^2}}}{\sqrt{x^2 +y^2}} dy$

The integral is not really suited for numerical integration as the limits are $k_0 \cdot a $ and $k_0 \cdot b$, which can be very large values indeed. Therefore, it is better to perform a substitution of variables and translate the double integral into:

$\frac{Z_r}{Z_0} = \frac{2i}{\pi k_0 a \cdot k_0 b} \left( \int_0^{\arctan(b/a)}{I(k_0 / a \cos(\varphi)) \, d \varphi} + \int_{\arctan(b/a)}^{\pi/2} {I(k_0 b/ \sin(\varphi) ) \, d\varphi } \right)$
The intermediate integral is given by:

$I(R) = \int_0^R{ (U + V \cdot r + W \cdot r^2) \cos(\alpha r) \cos(\beta r) \cdot e^{-i r} \, dr}$

With the variables:

$U = k_0 a \cdot k_0 b$

$V =-(k_0 a \sin(\phi) + k_0 b \cos(\phi))$

$W = \sin(\phi) \cos(\phi) = \sin(2 \cdot \phi)$

$\alpha = \mu_x \cos(\phi) = k_0 \cdot \sin(\theta_i) \cdot \cos( \phi_i ) \cdot \cos(\phi)$

$\beta = \mu_y \sin(\phi) = k_0 \cdot \sin(\theta_i) \cdot \sin( \phi_i ) \cdot \sin(\phi)$

The intermediate integral could be integrated by substituting the cosine terms with the identity:

$\cos(x) = \frac{e^{-i \cdot x} + e^{i \cdot x}}{2}$

Since every term is multiplied by $\cos(x)$ we can take the constant $1/4$ out of the integral, which can be a little simplified:

$I(R) =\frac{1}{4} \int_0^R (e^{ir (- \alpha - \beta -1)} +e^{ir (\alpha - \beta -1)}+e^{ir (- \alpha + \beta -1)}+e^{ir (\alpha + \beta -1)} ) \cdot (U + V \cdot r + W \cdot r^2) \, dr$

We now introduce a variable called $c_n$ which has the following 4 forms:

$c_1 = - \alpha - \beta -1$

$c_2 = \alpha - \beta -1$

$ c_3 = - \alpha + \beta -1$

$c_4 = \alpha + \beta -1$ $

Given that $n=1,2,3,4$ the general term for $c_n$:

$c_n = (-1)^n \cdot \alpha + (-1)^{\left(\frac{n^2 + n}{2}\right)} \cdot \beta -1$

$= (-1)^n \cdot \alpha + i^{\left(n(n+1)\right)} \cdot \beta -1$

There is also the possibility to combine the original values and simplify the expression for $c_n$:

$c_n = (-1)^{n}\cdot k_0 \cdot \sin(\theta) \cdot \cos{\left( \phi + i^{(n(n-1))} \cdot \varphi \right)}$

Resulting in:

$I(R,c_n) = \frac{1}{4}\sum_{n=1}^{4} \left(\int_0^R{e^{ir \cdot c_n } \cdot U \, dr} + \int_0^R{e^{ir \cdot c_n } \cdot V \cdot r \, dr} + \int_0^R{e^{ir \cdot c_n } \cdot W \cdot r^2 \, dr} \right) $

Using standard integration and integration by parts, these are easily solved:

$\int_0^R{e^{i c_n r} U \, dr} = - \frac{i U e^{i c_n R} }{c_n} + \frac{i U}{c_n} $

$\int_0^R{e^{i c_n r} V \cdot r \, dr} = V e^{i c_n R} \left( \frac{1}{c_n^2} - \frac{i R}{c_n}\right) - \frac{V}{c_n^2}$

$\int_0^R{e^{i c_n r} W \cdot r^2 \, dr} =W e^{i c_n R} \left( \frac{2 i }{c_n^3} + \frac{2R}{c_n^2} - \frac{i R^2}{c_n} \right) - \frac{2 i W}{c_n^3}$
Sorting out and rearranging gives the following:

$I(R) = \frac{1}{4 \cdot C_n^3} \sum_{n=1}^{4} e^{i \cdot C_n \cdot R} \cdot \left( - U \cdot i C_n^2 + V* \left(C_n - i \cdot C_n^2 \cdot R \right) + W \cdot \left( -i \cdot C_n^2 \cdot R^2 + 2 \cdot C_n \cdot R + 2 \cdot i \right) \right) + U \cdot i \cdot C_n^2 - V \cdot C_n - W \cdot 2 \cdot i$
The code that generates this integral can be implemented as such:

C#
Shrink ▲   
/// <summary>
/// Intermediate integral
/// </summary>
/// <param name="R">Upper integration limit</param>
/// <param name="C_n">Permutation group of 4 elements</param>
/// <param name="U">Constant depending size</param>
/// <param name="V">Constant depending on angle, size and wave number</param>
/// <param name="W">Constant dependent on angle only</param>
/// <returns></returns>
public static Complex I_R(Complex R, Complex C_n, Complex U, Complex V, Complex W)
{
    Complex C_n2 = C_n * C_n;
    Complex C_n3 = C_n2 * C_n;
    Complex i = new Complex(0, 1);
    Complex expR = Complex.Exp(i * C_n * R);
    
    Complex result =
        (   expR * (    - U * i * C_n2 
                        + V * (C_n - i * C_n2 * R) 
                        + W * (-i * C_n2 * R * R + 2 * C_n * R + 2 * i)
                    )
            +(  U * i * C_n2 
                - V * C_n 
                - W * 2 * i ) 
        ) / (C_n3 * 4);
        
    return result;
    
}
The two integrals can now easily be implemented by a Cauchy sum. Which is the same as the Riemann sum, only that a Cauchy sum uses finitely many elements while Riemann sets the number of elements to infinity.

C#
Shrink ▲   
// Integral one
for (double i = 0; i < arctan; i += deltaPhi)
{
    for (int n = 0; n < 4; n++)
    {
        // Generate sequence 1, -1, 1, -1
        double mod1 = (1 & n) == 0 ? 1 : -1;
        
        // Generate sequence 1, 1, -1, -1
        double mod2 = (2 & n) == 0 ? 1 : -1;
        
        Complex C_n = mod1 * alpha(i) + mod2 * beta(i) - 1;
        result += I_R(k0a / Math.Cos(i), C_n, U, V(i), W(i));
    }
}

// Integration two
for (double j = arctan; j < Math.PI / 2; j += deltaPhi)
{
    for (int n = 0; n < 4; n++)
    {
        // Generate sequence 1, -1, 1, -1
        double mod1 = (1 & n) == 0 ? 1 : -1;
        
        // Generate sequence 1, 1, -1, -1
        double mod2 = (2 & n) == 0 ? 1 : -1;
        
        Complex C_n = mod1 * alpha(j) + mod2 * beta(j) - 1;
        result += I_R(k0b / Math.Sin(j), C_n, U, V(j), W(j));
    }
}
If you are tempted to use some Newton-Coates-style summation, like Gaussian quadrature, you should remember that the requirement for using this is a realistically well-behaved function. There is no guarantee of that here, at least not in advance. That is why I opted for a more safe, straight-forward summation. This code also seems to be very stable even for massively large openings, like 100 times 100 meters.

For a rectangular piston just use the angles $\theta = 0$, $\phi = 0$. Also there are no need for special cases such at wide or narrow opening with this implementation.
