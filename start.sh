while [ 1 ]
do
    printf Running Jupyter notebook
    cd /data
    jupyter notebook --allow-root --ip=0.0.0.0 --port=80 --NotebookApp.token=''
    printf Sleeping...
    sleep 5
done
fi

