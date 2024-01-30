#!/usr/bin/env python
import os

import matplotlib as mpl
mpl.use('Agg')
import matplotlib.pyplot as plt
import numpy as np

# Generate sample data
x = np.linspace(0, 10, 100)
y = np.sin(x)
# Plot the data
plt.plot(x, y)
# Set the title and labels
plt.title("Sine Wave")
plt.xlabel("x-axis")
plt.ylabel("y-axis")

# Save the plot as a PNG, JPEG and PDF files
destination_pdf=os.environ.get('HOME')+"/z_simple_plot.pdf"
print(f'Figure saved as {destination_pdf}')
plt.savefig(destination_pdf)
####################### LAST line of file ##################################
