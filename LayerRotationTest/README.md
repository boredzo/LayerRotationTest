# LayerRotationTest

This app demonstrates some odd behavior in how AppKit handles changes to a layer's transform.

## Steps to Reproduce

1. Click the “Order In” button to order in the floating panel.
2. Use the circular slider to rotate the floating panel's view.
3. Click the “Order Out” button to order the floating panel out.
4. Click the “Order In” button again.

## Expected results

The geometry of the floating panel's view's layer hierarchy remains unchanged between steps 3 and 4.

## Actual results

The layer's bounds changes aspect ratio, seemingly in proportion to the rotation angle (or its slope?). The more level the angle, the more square the bounds.

## Notes

See log output for detailed reporting of the view's geometry and its layer's.
