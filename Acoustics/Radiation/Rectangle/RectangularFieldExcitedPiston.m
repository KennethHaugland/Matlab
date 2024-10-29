function z = RectangularFieldExcitedPiston(k_0, theta, psi, a, b, Z_0)
    if (k_0 == 0)
        z = 0;
    else

    %defining some constant terms
    k0a = k_0 .* a;
    k0b = k_0 .* b;
    mu_x = sin(theta) .* cos(psi);
    mu_y = sin(theta) .* sin(psi);
    arctan = atan(b ./ a);

    U = k0a .* k0b;
    V = @(phi) -(k0a .* sin(phi) + k0b .* cos(phi));
    W = @(phi) 0.5 .* sin(2 .* phi);
   
    alpha = @(phi) mu_x .* cos(phi);
    beta = @(phi) mu_y .* sin(phi);   

    % Default start value
    result = 0;

    % Integration resolution
    deltaPhi = 0.01;


    % Integral - part one
    mod1 = [1, -1, 1, -1];
    mod2 = [1, 1, -1, -1];

    for i=0:deltaPhi:arctan
        for n=1:1:4
            C_n = mod1(n) .* alpha(i) + mod2(n) .* beta(i) - 1;
            result = result + I_R(k0a ./ cos(i), C_n, U, V(i), W(i))./4;
        end
    end

   for i=arctan + deltaPhi:deltaPhi:pi/2
        for n=1:1:4
            C_n = mod1(n) .* alpha(i) + mod2(n) .* beta(i) - 1;
            result = result + I_R(k0a ./ sin(i), C_n, U, V(i), W(i))/4;
        end
    end

        z = Z_0 .* result .* deltaPhi .* 2i ./ (pi .* U);

    end

end

function result = I_R(R, C_n, U, V, W) 

    C_n2 = C_n .* C_n;
    C_n3 = C_n2 .* C_n;
    expR = exp(1i .* C_n .* R);

    u = -U .* 1i .* C_n2;
    v = V .* (C_n - 1i .* C_n2 .* R);
    w = W .*  (-1i .* C_n2 .* R .* R + 2 * C_n .* R + 2 .* 1i);    
    r = (U .* 1i .* C_n2 - V .* C_n - W .* 2 .* 1i);

    result = (expR .* (u + v + w) + r) ./ (C_n3);    
end