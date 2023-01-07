function [thersholded, k] = OtsuThersholding(image, offset)
histogram = zeros(1,256);
intensity_min = min(min(image));
intensity_max = max(max(image));
for i = intensity_min:intensity_max
    histogram(i+abs(intensity_min)+1)=length(find(image == i));
end
histogram = histogram/numel(image);
plot(intensity_min:intensity_max, histogram)
title('PDF')
P_1 = cumsum(histogram);
i_histogram = histogram;
for i = 1:length(histogram)
    i_histogram(i) = i*histogram(i);
end
m = cumsum(i_histogram);
figure
plot(intensity_min:intensity_max, m)
title('CDF')
m_G = m(end);
sigma2_B = ((m_G.*P_1 - m).^2)./(P_1.*(1 - P_1));
[~,k] = max(sigma2_B);
thersholded = image;
thersholded(thersholded>k+offset) = 0;
thersholded(thersholded<=k+offset) = 255;
end

