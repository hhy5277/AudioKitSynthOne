//
//  ADSRViewController.swift
//  AudioKitSynthOne
//
//  Created by Matthew Fecher on 7/24/17.
//  Copyright © 2017 AudioKit. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class ADSRViewController: SynthPanelController {

    @IBOutlet var adsrView: AKADSRView!
    @IBOutlet var filterADSRView: AKADSRView!
    @IBOutlet weak var attackKnob: MIDIKnob!
    @IBOutlet weak var decayKnob: MIDIKnob!
    @IBOutlet weak var sustainKnob: MIDIKnob!
    @IBOutlet weak var releaseKnob: MIDIKnob!
    @IBOutlet weak var filterAttackKnob: MIDIKnob!
    @IBOutlet weak var filterDecayKnob: MIDIKnob!
    @IBOutlet weak var filterSustainKnob: MIDIKnob!
    @IBOutlet weak var filterReleaseKnob: MIDIKnob!
    @IBOutlet weak var filterADSRMixKnob: MIDIKnob!
    @IBOutlet weak var envelopeLabelBackground: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        envelopeLabelBackground.layer.cornerRadius = 8

        guard let s = conductor.synth else { return }

        attackKnob.range = s.getRange(.attackDuration)
        decayKnob.range = s.getRange(.decayDuration)
        sustainKnob.range = s.getRange(.sustainLevel)
        releaseKnob.range = s.getRange(.releaseDuration)

        filterAttackKnob.range = s.getRange(.filterAttackDuration)
        filterDecayKnob.range = s.getRange(.filterDecayDuration)
        filterSustainKnob.range = s.getRange(.filterSustainLevel)
        filterReleaseKnob.range = s.getRange(.filterReleaseDuration)

        filterADSRMixKnob.range = s.getRange(.filterADSRMix)

        viewType = .adsrView

        conductor.bind(attackKnob, to: .attackDuration)
        conductor.bind(decayKnob, to: .decayDuration)
        conductor.bind(sustainKnob, to: .sustainLevel)
        conductor.bind(releaseKnob, to: .releaseDuration)
        conductor.bind(filterAttackKnob, to: .filterAttackDuration)
        conductor.bind(filterDecayKnob, to: .filterDecayDuration)
        conductor.bind(filterSustainKnob, to: .filterSustainLevel)
        conductor.bind(filterReleaseKnob, to: .filterReleaseDuration)
        conductor.bind(filterADSRMixKnob, to: .filterADSRMix)

        adsrView.callback = { att, dec, sus, rel in
            self.conductor.synth.setAK1Parameter(.attackDuration, att)
            self.conductor.synth.setAK1Parameter(.decayDuration, dec)
            self.conductor.synth.setAK1Parameter(.sustainLevel, sus)
            self.conductor.synth.setAK1Parameter(.releaseDuration, rel)
            self.conductor.updateAllUI()
        }

        filterADSRView.callback = { att, dec, sus, rel in
            self.conductor.synth.setAK1Parameter(.filterAttackDuration, att)
            self.conductor.synth.setAK1Parameter(.filterDecayDuration, dec)
            self.conductor.synth.setAK1Parameter(.filterSustainLevel, sus)
            self.conductor.synth.setAK1Parameter(.filterReleaseDuration, rel)
            self.conductor.updateAllUI()
        }
    }

    override func updateUI(_ param: AKSynthOneParameter, control: AKSynthOneControl?, value: Double) {
        switch param {
        case .attackDuration:
            adsrView.attackDuration = value
        case .decayDuration:
            adsrView.decayDuration = value
        case .sustainLevel:
            adsrView.sustainLevel = value
        case .releaseDuration:
            adsrView.releaseDuration = value
        case .filterAttackDuration:
            filterADSRView.attackDuration = value
        case .filterDecayDuration:
            filterADSRView.decayDuration = value
        case .filterSustainLevel:
            filterADSRView.sustainLevel = value
        case .filterReleaseDuration:
            filterADSRView.releaseDuration = value
        default:
            _ = 0
            // do nothing
        }
        adsrView.setNeedsDisplay()
        filterADSRView.setNeedsDisplay()
    }
}
