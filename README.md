# Parametric Poster Frame Component
# Overview
This repo contains an OpenSCAD file to create a 3d printable model for a poster frame component. The component provides the corners of a poster frame that uses wood dowel to connect the corners and magnets to hold the poster in place at the corners. The generated model has been 3d printed and tested.

This is my first OpenSCAD model and it is not 100% parametric. It needs the items in the TODO section to be completed to be 100% parametric.

STL files located in the `stl` directory.

The current models have been created and work with the following hardware:
- Porta 9.5mm Tasmanian Oak Dowel https://www.bunnings.com.au/porta-9-5mm-tasmanian-oak-dowel-1-2m_p0099360
- Everhang 8mm Rare Earth Disc Magnet - https://www.bunnings.com.au/everhang-8mm-rare-earth-disc-magnet-10-pack_p3690098
- Everhang 12mm Rare Earth Disc Magnet - https://www.bunnings.com.au/everhang-12mm-rare-earth-disc-magnet-6-pack_p3690099

# Images
![corner](/readme/images/corner.jpg)
![frame](/readme/images/frame.jpg)
![poster](/readme/images/poster.jpg)

# TODO
- [ ] Make fully parametric.
  - [ ] Fix magnet holder height offset magic number variable.
  - [ ] Make magnet holder module fully parametric.