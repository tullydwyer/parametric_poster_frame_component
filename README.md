# Parametric Poster Frame Component
# Overview
This repo contains an openscad file to create a 3d printable model for a poster frame component. The component provides the corners of a poster frame that uses wood dowel to connect the corners and magnets to hold the poster in place at the corners.

The generated model has been 3d printed and tested.

This is my first openscad model and it is not 100% parametric. It needs the items in the TODO section to be completed to be 100% parametric.

There are 2 files:

- `corner_component.scad` - Code I plan on improving.

- `corner_component_12.scad` - Code with the variables for 12mm neodymium magnets and 9.5mm wood dowell.

<!-- `corner_component_8.scad` - Code with the variables for 8mm neodymium magnets and 9.5mm wood dowell. -->

# TODO
- [ ] Make fully parametric.
  - [ ] Fix magnet holder height offset magic number variable.
  - [ ] Make magnet holder module fully parametric.