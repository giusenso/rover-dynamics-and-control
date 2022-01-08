function s = slipRatio(v_wheel,v_ref)

for i=1:length(v_ref)
    if v_wheel(i) >= v_ref(i)
        s(i) = (v_wheel(i)-v_ref(i))/v_wheel(i); % accelerating
    else
        s(i) = (v_wheel(i)-v_ref(i))/v_ref(i); % decelerating
    end
end