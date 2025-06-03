FROM harbor.alopezpa.homelab/system/base:v2.0.0-c01

USER root

ENV JAVA_VERSION=openjdk-17+35
ENV PATH="${MAVEN_HOME}/bin:${PATH}"
ENV JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}
ENV PATH="${JAVA_HOME}/bin:${PATH}"
ENV MAVEN_VERSION=3.9.6
ENV MAVEN_HOME=/usr/local/maven
ENV MAVEN_FILE=https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz

RUN microdnf update -y && microdnf clean all \
&& mkdir -p /usr/lib/jvm \
&& curl -fsSL https://download.java.net/openjdk/jdk17/ri/openjdk-17+35_linux-x64_bin.tar.gz | tar xzf - -C /usr/lib/jvm/ \
&& ln -s /usr/lib/jvm/jdk-17 ${JAVA_HOME} \
&& curl -fsSL $MAVEN_FILE | tar xzf - -C /usr/local \
&& ln -s /usr/local/apache-maven-$MAVEN_VERSION /usr/local/maven \
&& ln -s /usr/local/maven/bin/mvn /usr/local/bin/mvn

USER alopezpa
CMD ["bash"]
