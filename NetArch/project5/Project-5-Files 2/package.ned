package proj5net.simulations;

@license(LGPL);
import inet.common.misc.ThruputMeteringChannel;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.EthernetSwitch;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.visualizer.canvas.integrated.IntegratedCanvasVisualizer;


network RoutedNetwork
{
    @display("bgb=1610,875");

    types:
        // Common 100 Mbps channel used to connect most devices
        channel Channel extends ThruputMeteringChannel
        {
            delay = 0.1us;
            datarate = 100Mbps;
            thruputDisplayFormat = "u";
        }

        // "Slow" channel for one link at 10 Mbps and possible errors
        // Parameter per can be set to control the packet error rate on this link. Parameter
        // thruputDisplayFormat can be set to control display during annimation wiht #N giving
        // numer of packets, #u giving recent utilization, and #U giving utilization over all
        // time. See:
        // https://doc.omnetpp.org/inet/api-current/neddoc/inet.common.misc.ThruputMeteringChannel.html 
        channel ChannelSlow extends ThruputMeteringChannel
        {
            delay = 0.1us;
            datarate = 10Mbps;
            per = 0.01;
            thruputDisplayFormat = "u";
        }

    submodules:
        // IPv4 Configurator
        configurator: Ipv4NetworkConfigurator {
            @display("p=100,100");
        }

		// Hosts: host* and server
        host1: StandardHost {
            @display("p=552.795,98.8575");
            gates:
                ethg[1];
        }
        host2: StandardHost {
            @display("p=389.3775,143.2425");
            gates:
                ethg[1];
        }
        host3: StandardHost {
            @display("p=347.00998,288.5025");
            gates:
                ethg[1];
        }
        host4: StandardHost {
            @display("p=347.00998,484.19998");
            gates:
                ethg[1];
        }
        host5: StandardHost {
            @display("p=389.3775,641.565");
            gates:
                ethg[1];
        }
        host6: StandardHost {
            @display("p=552.795,687.96747");
            gates:
                ethg[1];
        }
        server: StandardHost {
            @display("p=1319.445,381.3075");
            gates:
                ethg[1];
        }
        
        // Routers: router*
        router1: Router {
            @display("p=746.475,288.5025");
            gates:
                ethg[2];
        }
        router2: Router {
            @display("p=746.475,484.19998");
            gates:
                ethg[2];
        }
        router3: Router {
            @display("p=960.32996,381.3075");
            gates:
                ethg[3];
        }

		// Ethernet switches:  switch*
        switch1: EthernetSwitch {
            @display("p=552.795,286.485");
            gates:
                ethg[4];
        }
        switch2: EthernetSwitch {
            @display("p=552.795,482.1825");
            gates:
                ethg[4];
        }
        switch3: EthernetSwitch {
            @display("p=1133.835,379.29");
            gates:
                ethg[2];
        }

		// Visualizer
        visualizer: IntegratedCanvasVisualizer {
            @display("p=98.8575,274.38");
        }

	// Connections: Use ChannelSlow for router1-router3 link
    connections:
        host1.ethg[0] <--> Channel <--> switch1.ethg[0];
        host2.ethg[0] <--> Channel <--> switch1.ethg[1];
        host3.ethg[0] <--> Channel <--> switch1.ethg[2];
        host4.ethg[0] <--> Channel <--> switch2.ethg[0];
        host5.ethg[0] <--> Channel <--> switch2.ethg[1];
        host6.ethg[0] <--> Channel <--> switch2.ethg[2];
        server.ethg[0] <--> Channel <--> switch3.ethg[0];
        
        switch1.ethg[3] <--> Channel <--> router1.ethg[0];
        switch2.ethg[3] <--> Channel <--> router2.ethg[0];
        switch3.ethg[1] <--> Channel <--> router3.ethg[0];
        
        router1.ethg[1] <--> ChannelSlow <--> router3.ethg[1];
        router2.ethg[1] <--> Channel <--> router3.ethg[2];
}