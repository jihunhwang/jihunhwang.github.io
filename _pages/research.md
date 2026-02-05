---
title: Research
# layout: splash
author_profile: true
permalink: /research/
# toc: true
search: exclude
sitemap: false
---


## Publications

<font size="3">
<p><i>Nota Bene: Authors are usually listed alphabetically, often even arbitrarily, among mathematicians and theoretical computer scientists. See <a href="http://www.ams.org/profession/leaders/CultureStatement04.pdf">this statement</a> from the American Mathematical Society for details.</i></p>
</font>

<!-- Template
<li>
	<b>title</b>
	<br>
	{{ "with (author names)" | link_colleagues }}
	<br>
	<b>(conference)</b> [<a href="link">PDF</a>] 
	<br>
	<details class="abstract-details" closed>
		<summary class="abstract-summary"></summary>
			<p>
				<span class="indented">
					text
				</span>
				<span class="indented">
					text
				</span>
				<span class="indented">
					text
				</span>
			</p>
	</details>
</li>
-->

Papers that reflects my current primary research interest the best:

<ol>

<li>
	<b>Resilience of Inner-Product Masking Scheme against Hamming Weight Leakage</b>
	<br>
	{{ "with Aniruddha Biswas, Hemanta Maji, and Xiuyu Ye" | link_colleagues }}
	<br>
	Preprint [<a href="https://www.cs.purdue.edu/homes/hmaji/papers/BHMY25.pdf">PDF</a>] 
	<br>
	<details class="abstract-details" closed>
		<summary class="abstract-summary"></summary>
			<p>
				<span class="indented">
					Additive masking is a widely used countermeasure against side-channel attacks in which a secret is additively split into multiple random shares. However, over binary fields, the number of 1's in the binary representation (i.e., the Hamming weight) of the shares reveals information about the original secret. Inner product masking scheme has been proposed as a promising alternative that is secure against such information leakage.
				</span>
				<span class="indented">
				In this work, we establish that inner product masking over a binary extension field is provably secure against Hamming weight leakage, and it translates into security against arbitrary symmetric function leakage from the shares. In addition, we present an efficiently computable score function that quantifies its security against leakages, enabling users to test and certify its security. Finally, we derive a relationship between the leakage resilience of inner-product masking and additive masking over an arbitrary field; they are at least as secure as additive masking.
				</span>
				<span class="indented">
				Our approach is Fourier-analytic and involves estimating spectral norms of the Hamming slice by studying Krawtchouk polynomials.
				</span>
			</p>
	</details>
</li>

<li>
	<b>Security of Shamir's Secret-sharing against Physical Bit Leakage: Secure Evaluation Places</b>
	<br>
	{{ "with Hai Nguyen, Hemanta Maji, and Xiuyu Ye" | link_colleagues }}
	<br> 
	<b>ITC 2025</b> [<a href="https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.ITC.2025.3">LIPIcs</a>] [<a href="https://www.cs.purdue.edu/homes/hmaji/papers/HMNY24.pdf">Full version</a>]
	<details class="abstract-details" closed>
		<summary class="abstract-summary"></summary>
			<p>
				<span class="indented">
					Can Shamir’s secret-sharing protect its secret even when all shares are partially compromised? 
				</span>
				<span class="indented">
					For instance, repairing Reed-Solomon codewords, when possible, recovers the entire secret in the corresponding Shamir’s secret sharing. Yet, Shamir’s secret sharing mitigates various side-channel threats, depending on where its "secret-sharing polynomial" is evaluated. Although most evaluation places yield secure schemes, none are known explicitly; even techniques to identify them are unknown. Our work initiates research into such classifier constructions and derandomization objectives. 
				</span>
				<span class="indented">
					In this work, we focus on Shamir’s scheme over prime fields, where every share is required to reconstruct the secret. We investigate the security of these schemes against single-bit probes into shares stored in their native binary representation. Technical analysis is particularly challenging when dealing with Reed-Solomon codewords over prime fields, as observed recently in the code repair literature. Furthermore, ensuring the statistical independence of the leakage from the secret necessitates the elimination of any subtle correlations between them. 
				</span>
				<span class="indented">
					In this context, we present:  
				</span>
				<span>
					1) An efficient algorithm to classify evaluation places as secure or vulnerable against the least-significant-bit leakage. 
				</span><br>
				<span>
					2) Modulus choices where the classifier above extends to any single-bit probe per share. 
				</span><br>
				<span>
					3) Explicit modulus choices and secure evaluation places for them.  On the way, we discover new bit-probing attacks on Shamir’s scheme, revealing surprising correlations between the leakage and the secret, leading to vulnerabilities when choosing evaluation places naïvely.
				</span>
				<span class="indented">
					Our results rely on new techniques to analyze the security of secret-sharing schemes against side-channel threats. We connect their leakage resilience to the orthogonality of square wave functions, which, in turn, depends on the 2-adic valuation of rational approximations. These techniques, novel to the security analysis of secret sharings, can potentially be of broader interest.
				</span>
			</p>
	</details>
</li>

</ol>

I also have a side interest in network algorithms/modeling, and computer security in general:

<ol>

<li>
	<b>Towards Practical Clock Synchronization in the Solar System Internet</b>
	<br>
	{{ "with Alan Hylton, Oliver Chiriac, Jacob Cleveland, Karuna Petwe, Tobias Timofeyev, and Robert Kassouf-Short" | link_colleagues }}
	<br>
	<b>IEEE AeroConf 2025</b> [<a href="https://ntrs.nasa.gov/citations/20250000364">NTRS</a>] 
	<br>
	<details class="abstract-details" closed>
		<summary class="abstract-summary"></summary>
			<p>
				<span class="indented">
					Clock synchronization remains a notable gap in the Delay Tolerant Networking (DTN) suite of protocols. However, following the great theoretical advances in the area and a highly successful DTN experiment campaign on the International Space Station (ISS), a strong enough foundation has been laid to support a practical clock synchronization protocol and implementation for the Solar System Internet (SSI). In this paper we work with the theoretical developments along with the lessons-learned from the DTN experiments to drive a clock synchronization protocol and implementation for practical SSI network architectures, complete with code and simulation analyses.
				</span>
				<span class="indented">
					In addition to the recent technical and feature growth of DTN, network architectures have begun taking center stage. This was particularly true with the ISS experiments which operated over a multitude of DTN network boundaries (as well as project and programmatic boundaries), yielding operational experience with proper DTN network architectures. Taking this a step further, it is expected that future users in space will subscribe to multiple service providers, implying multiple network areas and boundaries. Such an architecture is central to the upcoming LunaNet, which notably has nodes that do not neighbor authoritative clock sources.
				</span>
				<span class="indented">
					After covering the basics of DTN, we recall the most germane aspects of clock synchronization for DTNs. This includes remarks on routing in DTNs, which is often schedule-based; we emphasize that this alone demonstrates how crucial clock synchronization is for scalability. The introduction continues with a discussion of the ISS experiment network architectures and its implications for this work.
				</span>
				<span class="indented">
					The key components have been implemented and applied to clock synchronization for a portion of NASA's DTN experiments network.
					The implementation is openly available and will be integrated into the High-rate DTN (HDTN) implementation.
					We then cover parameter optimization and the ramifications of choosing underlying equation solvers for convergence. 
					Observations based on network architectures are used to explain the multiple implementation paths available in DTN and which one was chosen.
					We conclude with the analysis of a simulation based on the ISS network architecture and the future work thereby inspired.				
				</span>
			</p>
	</details>
</li>

<li>
	<b>On the Theory of Network Architectures in the Solar System Internet</b>
	<br>
	{{ "with Alan Hylton, Oliver Chiriac, Jacob Cleveland, Daniel Koizumi, Karuna Petwe, and Tobias Timofeyev" | link_colleagues }}
	<br>
	<b>IEEE AeroConf 2025</b> [<a href="https://ntrs.nasa.gov/citations/20250000365">NTRS</a>] 
	<br>
	<details class="abstract-details" closed>
		<summary class="abstract-summary"></summary>
			<p>
				<span class="indented">
					Delay Tolerant Networking (DTN) is maturing into a viable enabling technology for the so-called Solar System Internet (SSI). The focus of SSI is shifting towards modern network architectures and scalability, which goes beyond the underlying protocol suite of DTN. Following a record-setting experiment campaign on the International Space Station (ISS), there is a wealth of operational experience and lessons-learned based on the advent of service-provider oriented architectures available to propel humanity's ability to network in space to new levels. However, deeper understandings of extending these architectures to the solar-system level are not fully explored. In this paper, we combine this new information with previous theoretical advances to open new doors in DTN network modeling with an eye on practical means to designing, creating, and operating future space networks.
				</span>
				<span class="indented">
					The primary purpose of networking is scalability, however simply using DTN does not give this for free. Indeed, having a protocol suite does not inform the user on its best practices; in the case of DTN, best practices are not known. In particular, the ISS experiments illustrated the difficulty of uniting DTN network areas across project and programmatic boundaries. In traditional DTN routing, all nodes have the same schedule of contacts - known as a contact graph - and it is expected that these data are globally consistent. Approaches depending on omniscience neither scale nor generalize well, yet alternatives remain elusive as there is no standard temporospatial network modeling approach.
				</span>
				<span class="indented">
					We investigate the capability of various mathematical models of dynamic heterogeneous networks to capture critical features such as routing, data flow optimization, and network hierarchy detection for the Near Space Network’s upcoming real-mission deployment including LunaNet. To better encapsulate the multifaceted nature of space communications, we first explore sheaf constructions on hypergraphs and more accurately model time variation in our network using the theory of topos and moduli spaces. For algorithmic directions, we develop a framework for automated community and bottleneck detection using Ollivier-Ricci curvature and persistence homology, so we can either bypass or exploit the detected bottlenecks using network coding. 
				</span>
				<span class="indented">
					In establishing solid mathematical frameworks to model space communications, we will be able to better standardize more efficient and scalable network services for the upcoming Near-Space Network and design the architecture of the eventual Solar System Internet. Examples are given in the context of the ISS network experiment with a discussion on how these tools can be used in more general settings. Finally, we conclude with future research directions.
				</span>
			</p>
	</details>
</li>

<li>
	<b>A Proposed Clock Synchronization Method for the Solar System Internet</b>
	<br>
	{{ "with Michael Moy, Alan Hylton, Robert Kassouf-Short, Jacob Cleveland, Justin Curry, Mark Ronnenberg, Miguel Lopez, and Oliver Chiriac" | link_colleagues }}
	<br>
	<b>IEEE AeroConf 2024</b> [<a href="https://ntrs.nasa.gov/citations/20240000642">NTRS</a>] 
	<br>
	<details class="abstract-details" closed>
		<summary class="abstract-summary"></summary>
			<p>
				<span class="indented">
					Networked communications in space are necessary to achieve scalability in terms of the number of communicating nodes but also in terms of the overall system complexity. 
					A key component to such a system is the ability to synchronize clocks, which is the focus of this paper. 
					The so-called Solar System Internet (SSI) will be built upon Delay Tolerant Networking (DTN), which, in analogy to the Internet Protocol (IP), can be considered a suite of protocols necessary for networking in the space domain. 
					Therefore, our goal is to extend this suite to include a DTN clock synchronization capability, analogous to the Network Time Protocol (NTP) used in the Internet. 
					A motivating example of a network in space is NASA's LunaNet, a vision for a multi-hop multi-path network extending to the moon wherein not all nodes will have direct connections to an authoritative reference clock. 
					In this paper, we propose a general clock synchronization methodology and algorithm that could be used for LunaNet as well as more elaborate time-varying networks.
				</span>
				<span class="indented">
					In recent years, DTN has benefited from modeling efforts founded on the mathematical tool of \emph{sheaves}. 
					Here we continue this work to provide an approach to clock synchronization. 
					Due to the time-varying nature of space networks, absolute consensus is not possible. 
					However, the \emph{sheaf Laplacian} provides a practical, distributed approach to approximating consensus by allowing data to diffuse through the network. 
					In particular, the sheaf Laplacian is readily computable, lending our approach to implementation.
				</span>
				<span class="indented">
					Our approach is well suited to handle the difficulties of space networks. 
					For instance, differences in clock accuracy mean certain nodes are more authoritative than others; we can account for these differences through hierarchies in the network, generalizing the strata in NTP. 
					Furthermore, just as error estimation is an integral part of NTP, we are able to give concrete error bounds for our approach. 
					Indeed, different applications (e.g., communications schedules, pointing, navigation, distributed science) will have different requirements, hence it is necessary to maintain clocks within a given tolerance.
					We outline some of the necessary steps to turn our approach into a practical network protocol that could be used in DTN, and we conclude the paper with suggestions for future research.
				</span>
			</p>
	</details>
</li>

<li>
	<b>Multi-domain Routing in Delay Tolerant Networks</b>
	<br>
	{{ "with Alan Hylton, Brendan Mallery, Mark Ronnenberg, Miguel Lopez, Oliver Chiriac, Sriram Gopalakrishnan, and Tatum Rask" | link_colleagues }}
	<br>
	<b>IEEE AeroConf 2024</b> [<a href="https://ntrs.nasa.gov/citations/20240000640">NTRS</a>] 
	<br>
	<details class="abstract-details" closed>
		<summary class="abstract-summary"></summary>
			<p>
				<span class="indented">
					The goal of Delay Tolerant Networking (DTN) is to provide the \emph{missing ingredient} for the ever-growing collection of communicating nodes in our solar system to become a Solar System Internet (SSI). Great strides have been made in modeling particular types of DTNs, such as schedule- or discovery-based. Now, analogously to the Internet, these smaller DTNs can be considered routing domains which must be stitched together to form the overall SSI. In this paper, we propose a framework for cross-domain routing in DTNs as well as methodologies for detecting these sub-domains. Example time-varying networks are given to demonstrate the techniques proposed. 
				</span>
				<span class="indented">
					A basic component is the mathematical theory of sheaves, which unifies the underlying model of DTN routing algorithms, by giving rise to \emph{routing sheaves} -- these can be defined for the dynamic and scheduled networks as noted above, and can also be used to define the interfaces between these domains in order to route across them. An immediate application would be routing across discovery-based networks connected by scheduled networks.
				</span>
				<span class="indented">
					These DTN subdomains remain elusive, however, and need to become well-defined and properly sized for tractable computability. In particular, a balance must be determined between areas that are too large (i.e. large matrix computations) versus areas that are too small (i.e. ``many'' single-noded domains). Moreover, the connections between the domains should, at least locally, be chosen to optimize data flow and connectivity: we address this in three ways. First, tools from persistent homology are given to understand underlying structures, reminiscent of hierarchies in the Internet Protocol (IP) addressing. Second, we construct a notion of temporal graph curvature based on network geometry to analyze flows induced by dynamical processes on these networks. Finally, Schr{\"o}dinger Bridges, a tool arising from statistical physics, are proposed as a method of constructing flows on time-evolving networks with desirable properties such as speed, robustness, and load sensitivity. 
				</span>
				<span class="indented">
					We construct an approach to temporal hypergraphs to simultaneously model unicast, multicast, and broadcast, using the language of scheme theory, and then consider DTN network coding as a way to achieve network-level computation and organization. The paper concludes with a discussion and ideas for future work.
				</span>
			</p>
	</details>
</li>

<li>
	<b>Bundle Protocol version 7 Implementation with Configurable Faulty Network and Evaluation</b>
	<br>
	{{ "with Aidan Casey, Ethan Dickey, Sachit Kothari, Raushan Pandey, and Wenbo Xie" | link_colleagues }}
	<br>
	<b>IEEE WiSEE 2023</b> [<a href="https://cmsworkshops.com/WISEE2023/Papers/Uploads/FinalPapers/PaperNum/1022/20230724065844_698875_1022.pdf">PDF</a>] 
	[<a href="https://github.com/etdickey/BPv7Java">GitHub</a>] [<a href="https://youtu.be/aika4nRm7wM">Demo</a>] [<a href="https://github.com/etdickey/BPv7Java/blob/master/Presentation.pptx">Slides</a>]
	<br>
	<details class="abstract-details" closed>
		<summary class="abstract-summary"></summary>
			<p>
				<span class="indented">
					The Bundle Protocol (BP) is a key component that enables delay/disruption-tolerant networking (DTN), an overlay network architecture that facilitates communication in challenging environments with intermittent connectivity. Previous works on DTNs were largely on analyzing or optimizing DTNs instead of studying BP alone itself; hence, whether or not BP is still at an experimental stage must be studied. This work begins by presenting a lightweight implementation of BP Version 7 (BPv7) created by implementing only the required portions of RFC9171, with a new convergence layer that simulates expected and unexpected disruptions for testing purposes. Our implementation is lightweight enough to be easily extendable for additional tests and simple enough to be used for educational purposes. Some preliminary, lightweight experiments indicate that BPv7, even with only the required parts in RFC9171, can serve its purpose and still ensures essential functionalities. It tolerates disruptions and infinitely long delays well, as intended. Moreover, it handles large data dumps and floods of packets well, as long as they are infrequent. In the course of our implementation and experiments, we identified potential architectural, specification, and deployment-related flaws of BP, and suggested solutions or directions toward them from the perspective of software engineering and network algorithms.
				</span>
			</p>
	</details>
</li>

<li>
	<b>Toward Time Synchronization in Delay Tolerant Network based Solar System Internetworking</b>
	<br>
	{{ "with Alan Hylton, Natalie Tsuei, Mark Ronnenberg, Brendan Mallery, Jonathan Quartin, Colin Levaunt, Jeremy Quail, and Justin Curry" | link_colleagues }}
	<br>
	<b>IEEE AeroConf 2023</b> [<a href="https://ntrs.nasa.gov/citations/20230002534">NTRS</a>] 
	<br>
	<details class="abstract-details" closed>
		<summary class="abstract-summary"></summary>
			<p>
				<span class="indented">
					The expanding presence in space will place an increased dependency on networked communications– a scalable communications infrastructure; that is, the Solar System Internet (SSI). Upcoming developments towards a SSI include NASA’s upcoming LunaNet, or lunar Internet, which provides multi-hop multi-path communications using Delay Tolerant Networking (DTN). DTN has been an active area of research and development, particularly in routing, security, and optimization. DTNs are marked by mobility, disconnection, and a wide variance of latencies (propagation and processing delays). In this paper, we outline progress towards a theory of time synchronization across such a network.
				</span>
				<span class="indented">
					An underlying assumption of DTN is that the network is time synchronized already, rather than synchronization being provided as a service. While this is necessary for schedule-based routing, which is necessarily prevalent in DTNs, it is so deeply ingrained as to be built into the primary unit of data in DTNs– the bundle. Indeed, a bundle’s creation timestamp and its time to live (called the lifetime) are based on time, and there are special recommendations for systems that lack accurate clocks. The assumption of time synchronization makes sense when limiting considerations to smaller-scale and more traditional space communication. However, just as end-to-end connectivity cannot be guaranteed in DTNs, neither can access to a reference or authoritative clock. In this more general case, it might be necessary to synchronize over time-varying meshes, and perhaps even to consider relativistic effects. Moreover, by imposing synchronization restrictions in order to sustain a network, the effectiveness of the network to achieve scalability will be necessarily muted.
				</span>
				<span class="indented">
					To work towards a time synchronization theory for DTNs, we build upon past successes in modeling DTNs using time-varying graphs and sheaves. This includes error and limitation estimation, which allows one to define domains over which schedule-based routing is possible, up to some threshold sensitivity. Despite the theoretical nature of these results, the approaches taken are also algorithmic, and hence lend themselves to practical implementations. The paper concludes with comparisons of the various methods along with suggestions for future work.
				</span>
			</p>
	</details>
</li>

<li>
	<b>Advances in Modeling Solar System Internet Structures and their Data Flows</b>
	<br>
	{{ "with Alan Hylton, Natalie Tsuei, Mark Ronnenberg, Brendan Mallery, Jonathan Quartin, Colin Levaunt, and Jeremy Quail" | link_colleagues }}
	<br>
	<b>IEEE AeroConf 2023</b> [<a href="https://ntrs.nasa.gov/citations/20230002531">NTRS</a>] 
	<br>
	<details class="abstract-details" closed>
		<summary class="abstract-summary"></summary>
			<p>
				<span class="indented">
					With an ever-increasing presence in space, there is also an increasing burden on existing communications infrastructure. We are heading towards an inflection point where the traditional approach of scheduled, single-path communications for space will no longer be viable. One answer is Delay Tolerant Networking (DTN), which takes the once disparate system of point-to-point links and unifies them in a networked architecture, thereby making communications more scalable. However, much work remains for discovering and harnessing the underlying theory of DTN. For example, in the terrestrial setting the interplay between routing domains is well-understood, however this is not the case in DTNs. In this paper, we build up the fundamental foundations of DTN, with an emphasis on modeling time varying networks and data flows across them, with examples of cross-domain routing in a DTN.
				</span>
				<span class="indented">
					A lofty goal of DTN is to enable the so-called Solar System Internet (SSI), which implies a standardized and robust suite of protocols. These protocols include routing across disconnected networks using store, carry, and forward mechanisms, which is necessary due to the disconnections, delays, and mobility intrinsic to space networks. Due to these factors, each of which generalize traditional networking, there is a deep and rich theory of DTNs. Here we build off of past successes to broaden this theory while striving to keep actionable results a goal for future implementations and operations.
				</span>
				<span class="indented">
					The approach includes modeling the unicast, broadcast, and multicast communications using the language of hypergraphs, which capture the geometric properties of such networked communications algebraically. Also inherent to these networks is their time-varying nature, particularly given mobility, and hence we also cultivate modeling techniques that respect this time dependence. This leads us to develop models using tools from category theory and algebraic geometry, which provide a language well-suited to describing synchronization and optimization over such networks. We also introduce and study a novel generalization of curvature applicable to time-evolving networks, which provides quantitative controls on diffusion processes on the network.
				</span>
				<span class="indented">
					Because an interplanetary network would feature links with propagation delays the preclude discovery (feedback) mechanisms, they will always feature a scheduled component. However, it is beneficial to support discovery where possible. While DTNs do not yet have strong definitions for their analogues of autonomous systems or network areas, we show how to join dynamic and schedule-based routing domains, using the language of sheaves, which marks progress towards such definitions. We conclude with a discussion of the progress made, as well as suggestions for future work.
				</span>
			</p>
	</details>
</li> 

<li>
	<b>A Security Assessment for Consumer WiFi Drones</b>
	<br>
	{{ "with Joshua Gordon, Victoria Kraj, and Ashok Raja" | link_colleagues }}
	<br>
	<b>IEEE ICII 2019</b> [<a href="https://par.nsf.gov/biblio/10157750">NSF</a>] 
	<br>
	<details class="abstract-details" closed>
		<summary class="abstract-summary"></summary>
			<p>
				<span class="indented">
					Small-scale unmanned aerial vehicles (UAVs) have become an increased presence in recent years due to their decreasing price and ease of use. Similarly, ways to detect drones through easily accessible programs like WireShark have raised more potential threats, including an increase in ease of jamming and spoofing drones utilizing commercially of the shelf (COTS) equipment like software defined radio (SDR). Given these advancements, an active area of research is drone security. Recent research has focused on using a HackRF SDR to perform eavesdropping or jamming attacks; however, most have failed to show a proposed remediation. Similarly, many research papers show post analysis of communications, but seem to lack a conclusive demonstration of command manipulation. Our security assessment shows clear steps in the manipulation of a WiFi drone using the aircrack-ng suite without the need for additional equipment like a SDR. This shows that anyone with access to a computer could potentially take down a drone. Alarmingly, we found that the COTS WiFi drone in our experiment still lacked the simple security measure of a password, and were very easily able to take over the drone in a deauthorization attack. We include a proposed remediation to mitigate the preformed attack and assess the entire process using the STRIDE and DREAD models. In doing so, we demonstrate a full attack process and provide a resolution to said attack. 
				</span>
			</p>
	</details>
</li> 

</ol>


## Unpublished Writeups


## People

<style>
/* Abstract summary */
summary.abstract-summary {
  font-size: 0.8em;   /* smaller summary font */
  text-decoration: underline;
}

details.abstract-details p {
  font-size: 0.8em; /* slightly smaller */
  padding-left: 1em;  /* indent the summary text */
  display: block;     /* ensures padding applies properly */
}

summary.abstract-summary::after {
  content: " Abstract (click to expand)";
}

details[open] summary.abstract-summary::after {
  content: " Abstract (click to collapse)";
}

/* BibTeX summary */
summary.bibtex-summary {
  font-size: 0.7em; /* even smaller */
}

summary.bibtex-summary::after {
  content: " BibTeX (click to expand)";
}

details[open] summary.bibtex-summary::after {
  content: " BibTeX (click to collapse)";
}

p span.indented {
  display: block;      /* each line behaves like a block */
  text-indent: 1em;    /* indent the first line of each block */
}
</style>
