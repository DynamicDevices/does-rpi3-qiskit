# base-image for python on any machine using a template variable,
# see more about dockerfile templates here: https://www.balena.io/docs/learn/develop/dockerfile/
FROM balenalib/%%BALENA_MACHINE_NAME%%-python:3-stretch-run

# use `install_packages` if you need to install dependencies,
# for instance if you need git, just uncomment the line below.
RUN install_packages libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

RUN install_packages build-essential libffi-dev libssl-dev git
RUN pip install Cython
RUN pip install --upgrade pip

RUN python -V

RUN install_packages libblas3 liblapack3 liblapack-dev libblas-dev gfortran

# Current release of qiskit-terra doesn't includ build files for RPi so use repo master
RUN pip install -e git+https://github.com/Qiskit/qiskit-terra.git#egg=qiskit-terra

# Now install qiskit - this fails as it tries to install an old qiskit-terra
#RUN pip install -e git+https://github.com/Qiskit/qiskit.git#egg=qiskit

# Qiskit is a meta-package so install the dependencies ourselves
RUN pip install qiskit-aer
RUN pip install qiskit-ibmq-provider
RUN pip install qiskit-ignis

RUN install_packages libsuitesparse-dev
RUN install_packages swig
RUN pip install --upgrade scikit-umfpack

RUN install_packages wget
RUN wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.5.3.tar.gz
RUN tar -xf SuiteSparse-4.5.3.tar.gz
RUN export CVXOPT_SUITESPARSE_SRC_DIR=${pwd}/SuiteSparse && pip install cvxopt

RUN pip install -e git+https://github.com/DynamicDevices/qiskit-aqua.git#egg=qiskit-aqua

RUN git clone https://github.com/sunqm/libcint.git
RUN cd libcint && git checkout origin/cint3
RUN install_packages cmake
RUN cd libcint && mkdir build && cd build && cmake .. && make install

RUN install_packages libhdf5-dev libhdf5-serial-dev hdf5-tools
#RUN find / -iname "hdf5.h"
# Couldn't get 2.9.0 installed...
#RUN export C_INCLUDE_PATH=/usr/include/hdf5/serial && pip install --no-binary=h5py "h5py==2.8.0"
#RUN find / -iname "libhdf5*"
RUN export HDF5_DIR=/usr/lib/arm-linux-gnueabihf/hdf5/serial && pip install --no-binary=h5py "h5py==2.8.0"

RUN find / -iname "hdf5.h"
#RUN export PYSCF_INC_DIR=/usr/local/lib && pip install pyscf

#RUN find / -name "libcint*"
#RUN export PYSCF_INC_DIR=/usr/local/lib && pip install pyscf

RUN git clone https://github.com/sunqm/pyscf 
RUN cd pyscf && cd pyscf/lib && mkdir build && cd build && cmake .. && make

RUN pip install /pyscf

RUN export PYTHONPATH=/pyscf:$PYTHONPATH && export PYSCF_INC_DIR=/pyscf/pyscf/lib/deps/lib && pip install qiskit-chemistry

# Install Jupyter
RUN pip install jupyter

# Set our working directory
WORKDIR /usr/src/app

# This will copy all files in our root to the working  directory in the container
COPY . ./

# Enable udevd so that plugged dynamic hardware devices show up in our container.
ENV UDEV=1

# main.py will run when container starts up on the device
#CMD ["python","-u","src/main.py"]
#CMD ["sleep", "infinity"]
CMD ["./start.sh"]

