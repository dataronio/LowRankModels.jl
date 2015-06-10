using LowRankModels

function BASIC_FUNCTIONALITY_QUAD()
# tests basic functionality of glrm.jl
	using LowRankModels
	srand(1);
	m,n,k,s = 1000,1000,5,1000*1000;
	# matrix to encode
	X_real, Y_real = randn(m,k), randn(k,n);
	A = X_real*Y_real;
	losses = fill(quadratic(),n);
	rx, ry = zeroreg(), zeroreg();
	glrm = GLRM(A,losses,rx,ry,5, scale=false, offset=false);

	p = Params(1, max_iter=200, convergence_tol=0.0000001, min_stepsize=0.001) 
	X,Y,ch = fit!(glrm, params=p);
	Ah = X'*Y;
	p.convergence_tol > abs(vecnorm(A-Ah)^2 - ch.objective[end])
end