reg_name='registry'
reg_port='5000'

#Check if docker is running.
rep=$(curl -s --unix-socket /var/run/docker.sock http://ping > /dev/null)
status=$?
if [ "${status}" = "7" ]; then
		sudo service docker start
			echo $?
				sleep 10
fi	

#:Start a local Docker registry (unless it already exists)
running="$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)"
if [ "${running}" != 'true' ]; then
	  docker run \
		      -d --restart=always -p "${reg_port}:5000" --name "${reg_name}" -v registry-images:/var/lib/registry  \
		          registry:2 
fi
