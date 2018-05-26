//
//  DevViewController.swift
//  AudioKitSynthOne
//
//  Created by Matthew Fecher on 12/2/17.
//  Copyright © 2017 AudioKit. All rights reserved.
//

import AudioKit
import UIKit

protocol DevPanelDelegate {
    func freezeArpChanged(_ value: Bool)
    func getFreezeArpChangedValue() -> Bool
}

class DevViewController: UpdatableViewController {

    var delegate: DevPanelDelegate?

    @IBOutlet weak var masterVolume: Knob! // i.e., gain before compressorMaster
    @IBOutlet weak var compressorMasterRatio: Knob!
    @IBOutlet weak var compressorReverbInputRatio: Knob!
    @IBOutlet weak var compressorReverbWetRatio: Knob!

    @IBOutlet weak var compressorMasterThreshold: Knob!
    @IBOutlet weak var compressorReverbInputThreshold: Knob!
    @IBOutlet weak var compressorReverbWetThreshold: Knob!

    @IBOutlet weak var compressorMasterAttack: Knob!
    @IBOutlet weak var compressorReverbInputAttack: Knob!
    @IBOutlet weak var compressorReverbWetAttack: Knob!

    @IBOutlet weak var compressorMasterRelease: Knob!
    @IBOutlet weak var compressorReverbInputRelease: Knob!
    @IBOutlet weak var compressorReverbWetRelease: Knob!

    @IBOutlet weak var compressorMasterMakeupGain: Knob!
    @IBOutlet weak var compressorReverbInputMakeupGain: Knob!
    @IBOutlet weak var compressorReverbWetMakeupGain: Knob!

    @IBOutlet weak var delayInputFilterCutoffFreqTrackingRatio: Knob!
    @IBOutlet weak var delayInputFilterResonance: Knob!

    @IBOutlet weak var freezeArpRate: ToggleButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Defaults, limits
        guard let s = conductor.synth else { return }

        // masterVolume is the input gain to compressorMaster
        masterVolume.range = s.getRange(.masterVolume)
        conductor.bind(masterVolume, to: .masterVolume)

        // reverb/master dynamics
        compressorMasterRatio.range = s.getRange(.compressorMasterRatio)
        compressorReverbInputRatio.range = s.getRange(.compressorReverbInputRatio)
        compressorReverbWetRatio.range = s.getRange(.compressorReverbWetRatio)
        conductor.bind(compressorMasterRatio, to: .compressorMasterRatio)
        conductor.bind(compressorReverbInputRatio, to: .compressorReverbInputRatio)
        conductor.bind(compressorReverbWetRatio, to: .compressorReverbWetRatio)

        compressorMasterThreshold.range = s.getRange(.compressorMasterThreshold)
        compressorReverbInputThreshold.range = s.getRange(.compressorReverbInputThreshold)
        compressorReverbWetThreshold.range = s.getRange(.compressorReverbWetThreshold)
        conductor.bind(compressorMasterThreshold, to: .compressorMasterThreshold)
        conductor.bind(compressorReverbInputThreshold, to: .compressorReverbInputThreshold)
        conductor.bind(compressorReverbWetThreshold, to: .compressorReverbWetThreshold)

        compressorMasterAttack.range = s.getRange(.compressorMasterAttack)
        compressorReverbInputAttack.range = s.getRange(.compressorReverbInputAttack)
        compressorReverbWetAttack.range = s.getRange(.compressorReverbWetAttack)
        conductor.bind(compressorMasterAttack, to: .compressorMasterAttack)
        conductor.bind(compressorReverbInputAttack, to: .compressorReverbInputAttack)
        conductor.bind(compressorReverbWetAttack, to: .compressorReverbWetAttack)

        compressorMasterRelease.range = s.getRange(.compressorMasterRelease)
        compressorReverbInputRelease.range = s.getRange(.compressorReverbInputRelease)
        compressorReverbWetRelease.range = s.getRange(.compressorReverbWetRelease)
        conductor.bind(compressorMasterRelease, to: .compressorMasterRelease)
        conductor.bind(compressorReverbInputRelease, to: .compressorReverbInputRelease)
        conductor.bind(compressorReverbWetRelease, to: .compressorReverbWetRelease)

        compressorMasterMakeupGain.range = s.getRange(.compressorMasterMakeupGain)
        compressorReverbInputMakeupGain.range = s.getRange(.compressorReverbInputMakeupGain)
        compressorReverbWetMakeupGain.range = s.getRange(.compressorReverbWetMakeupGain)
        conductor.bind(compressorMasterMakeupGain, to: .compressorMasterMakeupGain)
        conductor.bind(compressorReverbInputMakeupGain, to: .compressorReverbInputMakeupGain)
        conductor.bind(compressorReverbWetMakeupGain, to: .compressorReverbWetMakeupGain)

        //delay input filter
        delayInputFilterCutoffFreqTrackingRatio.range = s.getRange(.delayInputCutoffTrackingRatio)
        delayInputFilterResonance.range = s.getRange(.delayInputResonance)
        conductor.bind(delayInputFilterCutoffFreqTrackingRatio, to: .delayInputCutoffTrackingRatio)
        conductor.bind(delayInputFilterResonance, to: .delayInputResonance)

        // freeze arp rate
        if let value = delegate?.getFreezeArpChangedValue() {
            freezeArpRate.value = value ? 1 : 0
        }
        freezeArpRate.callback = { value in
            self.delegate?.freezeArpChanged(value == 1 ? true : false)
        }
    }
}
