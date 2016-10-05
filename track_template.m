function [result, it, res] = track_template(im, im_template, init, max_steps, epsilon)
%TRACK_TEMPLATE Locates a template in an image
%   Locates a template in an image based on iterative least 
%   squares over the residual image intensities.
%
%   Input ::
%       im : NxM Double Matrix of image to track template in
%       im_template : PxQ Double Matrix of template to track in im
%       init : Initial transform to use for search
%       max_steps : Maximum number of iterations to use on optimisation
%           (Default 50)
%       epsilon : Minimum difference between iteration solutions 
%           (Default 1e-1)
%
%   Output ::
%       result : Updated solution
%       it : Iterations required to reach solution
%       res : Residual at solution

%% Initialise default parameter values
if ~exist('max_steps', 'var')
    max_steps = 50;
end

if ~exist('epsilon', 'var')
    epsilon = 1e-1;
end

%% Calculate image gradient

[gx, gy] = imgradientxy(im, 'central');

%% Initialise 

% Optimisation variables

t_kp = init;
t_k = zeros(size(init));

% Construct template index vectors
template_size = size(im_template);
[u, v] = meshgrid(0:template_size(2)-1, 0:template_size(1)-1);
u = u(:);
v = v(:);

% Vectorise template
I_t = im_template(:);

% A matrix
tplt_vec_size = size(I_t);
ones_array = ones(tplt_vec_size);
zeros_array = zeros(tplt_vec_size);

A_x = vertcat(ones_array, zeros_array);
A_y = vertcat(zeros_array, ones_array);

A = horzcat(A_x, A_y);


%% Iterate towards solution
for it = 1:max_steps
    
    % Calculate point mapping
    ud = u + t_kp(1);
    vd = v + t_kp(2);
    
    % Calculate residuals
    r = interp2(im, ud, vd) - I_t;
    r = vertcat(r, r);
    
    % Calculate residual pde
    dr_x = interp2(gx, ud, vd);
    dr_y = interp2(gy, ud, vd);
    
    dr = vertcat(dr_x, dr_y);
    
    % Initialise weightings
    % Weight to remove small gradients
    w = true(size(dr));
    w(abs(dr) < 0.01) = false;
    
    % Construct t vector for b
    t_x = t_kp(1) * ones_array;
    t_y = t_kp(2) * ones_array;
    
    t = vertcat(t_x, t_y);
    
    % Construct q (b) vector
    q = t - r./dr;
    %fprintf('%g\n', min(abs(dr)));
    
    % Weight A for solving
    Aw = bsxfun(@times, A, w);
    rw = q.*w;
    
    % Update solution
    t_k = Aw\rw;

    % Calculate solution difference
    t_diff = t_k - t_kp;

    % Check if solution settled
    % If settled escape
    if norm(t_diff) < epsilon
        break
    end

    % If not settled
    % Update solution for next iteration
    t_kp = t_k;

end

result = t_k;
res = norm(t_diff);

end

