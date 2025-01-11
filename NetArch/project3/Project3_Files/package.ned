package pr3ospfv3first.simulations;

@license(LGPL);

// This a simple network with five OSPFv3 routers and four hosts

import inet.common.misc.ThruputMeteringChannel;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.EthernetSwitch;
import inet.node.inet.StandardHost;
import inet.node.ospfv3.Ospfv3Router;

network firstNet
{
    @display("bgb=650,500");
    types:

        // Common channel used to connect all devices
        channel Channel extends ThruputMeteringChannel
        {
            delay = 0.1us;
            datarate = 100Mbps;
            thruputDisplayFormat = "#N";
        }
    submodules:

        // IPv4 network configurator with overrides for IPv4 address assignment
        configurator: Ipv4NetworkConfigurator {
            parameters:
                config = xml("<config>"+
                            "<interface among='Router1 Router5' address='192.168.1.x' netmask='255.255.255.0' />"+
                            "<interface among='Router2 Router5' address='192.168.2.x' netmask='255.255.255.0' />"+
                            "<interface among='Router3 Router5' address='192.168.3.x' netmask='255.255.255.0' />"+
                            "<interface among='Router4 Router5' address='192.168.4.x' netmask='255.255.255.0' />"+
                            "<interface among='Router1 Host1' address='172.16.10.x' netmask='255.255.255.0' />"+
                            "<interface among='Router2 Host2' address='172.16.20.x' netmask='255.255.255.0' />"+
                            "<interface among='Router3 Host3' address='172.16.30.x' netmask='255.255.255.0' />"+
                            "<interface among='Router4 Host4' address='172.16.40.x' netmask='255.255.255.0' />"+
                            "</config>");
                @display("p=50,50");
        }

        // OSPFv3 routers
        Router1: Ospfv3Router {
            parameters:
                @display("p=200,350");
            gates:
                ethg[2];
        }
        Router2: Ospfv3Router {
            parameters:
                @display("p=450,350");
            gates:
                ethg[2];
        }
        Router3: Ospfv3Router {
            @display("p=450,150");
            gates:
                ethg[2];
        }
        Router4: Ospfv3Router {
            @display("p=200,150");
            gates:
                ethg[2];
        }
        Router5: Ospfv3Router {
            @display("p=325,250");
            gates:
                ethg[4];
        }

        // Standard hosts
        Host1: StandardHost {
            @display("p=100,350");
            gates:
                ethg[1];
        }
        Host2: StandardHost {
            @display("p=550,350");
            gates:
                ethg[1];
        }
        Host3: StandardHost {
            @display("p=550,150");
            gates:
                ethg[1];
        }
        Host4: StandardHost {
            @display("p=100,150");
            gates:
                ethg[1];
        }

    // Router-to-router and host-to-router connections
    connections:
        Router1.ethg[0] <--> Channel <--> Router5.ethg[0];
        Router2.ethg[0] <--> Channel <--> Router5.ethg[1];
        Router3.ethg[0] <--> Channel <--> Router5.ethg[2];
        Router4.ethg[0] <--> Channel <--> Router5.ethg[3];

        Router1.ethg[1] <--> Channel <--> Host1.ethg[0];
        Router2.ethg[1] <--> Channel <--> Host2.ethg[0];
        Router3.ethg[1] <--> Channel <--> Host3.ethg[0];
        Router4.ethg[1] <--> Channel <--> Host4.ethg[0];
}

