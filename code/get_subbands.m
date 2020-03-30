function subbands = get_subbands(surface, num)
%surface: surface to docompose
%num: the surface will be decomposed into num+2 subbands

c = 1.35;

%N = 200;

%sigma = zeros(num, 1);

subbands = zeros(num+2, 249, 299);

subbands(1, :, :) = surface - imgaussfilt(surface, c);

for i = 1:num
    sigma = c^i;
    trend1 = imgaussfilt(surface, sigma);
    trend2 = imgaussfilt(surface, sigma * c);
    subbands(i+1,:,:) = trend1 - trend2;
end

subbands (num+2, :, :) = imgaussfilt(surface, c^(num+1));

end