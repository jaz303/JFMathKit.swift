TARGETS = \
	Sources/Complexd.swift \
	Sources/Vec2d.swift \
	Sources/Vec3d.swift \
	Sources/Vec4d.swift \
	Sources/Mat4d.swift	

%d.swift: %f.swift
	./Scripts/float-to-double $< $@

all: $(TARGETS)

clean:
	rm -f $(TARGETS)
